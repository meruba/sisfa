class UserSessionsController < ApplicationController
  
  def new
    if current_user
      redirect_to :controller => :clientes, :action => :new
    end
  end

  def create 
    if @user = login(params[:username], params[:password])
       # session[:user_id] = @user.id
       redirect_back_or_to(clientes_path, notice: "Bienvenido")
    else
      flash[:error] = "Usuario o Contrasena invalido"
      redirect_to root_path
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "Has Cerrado Sesion"
  end
end
