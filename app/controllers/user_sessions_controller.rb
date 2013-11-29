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
      flash[:error] = "Ups! algo salio mal"
      render 'new'
    end
  end

  def destroy
    logout
    # session[:user_id] = nil
    redirect_to root_path, notice: "Adios"
  end
end
