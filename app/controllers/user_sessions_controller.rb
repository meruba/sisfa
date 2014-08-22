class UserSessionsController < ApplicationController

  def new
  end

  def create
    if @user = login(params[:username], params[:password])
      if @user.suspendido
        logout
        redirect_to login_path
        flash[:error] = "Usuario suspendido"
      else
        redirect_to root_path
        flash[:notice] = "Bienvenido #{current_user.username}"
      end
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
