class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :suspender,:edit, :update]
  skip_before_filter :require_login, :except => [:new]

  def index
    @users = User.all
  end
  
  def show
  end

 	def new
  	@user = User.new
    @user.build_cliente
  end

  def edit
    # @user = User.find(params[:id])
    respond_to do |format|
      format.js{ render "init" }
    end
  end

  def create
    @user = User.new(user_params)
      if @user.save
        redirect_back_or_to(users_path, notice: "Nuevo Usuario")
      else
        flash[:error] = "Ups! Algo salio mal.."
      end
  end

  def update
    cliente_attrs = params[:user].delete :cliente_attributes
    @cliente = Cliente.update(cliente_attrs[:id],cliente_attrs)
    respond_to do |format|
      if @user.update(user_params)
        @users = User.all
        format.html { redirect_to @user, notice: 'Usuario actualizado' }
        format.json { render action: 'show', status: :created, location: @user }
        format.js { render "success"}
      else
        # raise 'error'
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js { render "success"}
      end
    end
  end

  def suspender
    if @user.suspendido
      @user.suspendido = false
    else
      @user.suspendido = true
    end
    @user.save
    redirect_to users_path, :notice => "Usuario Suspendido"    
  end

  private 
    def user_params
      params.require(:user).permit :username,
                                    :password,
                                    :password_confirmation,
                                    :suspendido,
                                    :rol,
                                    :cliente_attributes => [
                                      :nombre,
                                      :numero_de_identificacion,
                                      :direccion,
                                      :telefono,
                                      :email,
                                      :created_at,
                                      :updated_at
                                    ]
    end

    def set_user
      @user = User.find(params[:id])
    end
end

