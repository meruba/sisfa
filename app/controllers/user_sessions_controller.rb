class UserSessionsController < ApplicationController

  def new
    if current_user
      redirect_to :controller => :clientes, :action => :new
    end
  end

  def create 
    if @user = login(params[:username], params[:password])
       redirect_to root_path
       flash[:notice] = "Bienvenido #{current_user.username}"
     else
      flash[:error] = "Usuario o contraseña inválido"
      redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: "Has Cerrado Sesión"
  end
end
