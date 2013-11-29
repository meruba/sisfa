class UsersController < ApplicationController

 	def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        # redirect_to(:controller => 'clientes', :action => 'new')
        flash[:success] = "Nuevo Usuario.."
      else
        flash[:error] = "Ups! Algo salio mal.."
      end
  end

  private 
    def user_params
      params.require(:user).permit(:username, :password)
    end

end
