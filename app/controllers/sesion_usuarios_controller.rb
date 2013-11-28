class SesionUsuariosController < ApplicationController

  def create 
    	user = login(params[:username], params[:password])
			 if user
  		  redirect_back_or_to root_url, :notice => "Logged in!"
 			 else
  		  flash.now.alert = "username or password was invalid"
  		  render :new
  		end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
