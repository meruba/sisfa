class UsersController < ApplicationController
  
  before_action :set_user, only: [:suspender]    
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
    @user = User.find(params[:id])
    respond_to do |format|
      format.js{ render "init" }
    end
  end

  def create
    @user = User.new(current_user_params) 
      if @user.save
        redirect_back_or_to(users_path, notice: "Nuevo Usuario")
      else
        flash[:error] = "Ups! Algo salio mal.."
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
    def current_user_params
      params.require(:user).permit :username,
                                    :password,
                                    :password_confirmation,
                                    :suspendido,
                                    :rol,
                                    :cliente_attributes => [
                                      :nombre,
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

