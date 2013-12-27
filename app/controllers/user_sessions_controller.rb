class UserSessionsController < ApplicationController

  def new
    if current_user
      redirect_to :controller => :clientes, :action => :new
    end
  end

  def create 
    if @user = login(params[:username], params[:password])
       redirect_to root_path
       flash[:notice] = "Bienvenido"
     else
      flash[:error] = "Usuario o Contrasena invalido"
      redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: "Has Cerrado Sesion"
  end
end
