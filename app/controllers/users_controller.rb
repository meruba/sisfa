class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :suspender,:edit, :update]
  before_filter :require_login

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
    rol = params[:user].delete :rol
    @user = User.new(user_params)
    @user.rol = Rol.where(:id => rol).first
      if @user.save
         redirect_to users_path, notice: 'Usuario Creado'
      else
        render 'new'
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
    redirect_to users_path, :notice => "Usuario modificado"    
  end

  private 
    def user_params
      params.require(:user).permit :username,
                                    :password,
                                    :password_confirmation,
                                    :suspendido,
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

