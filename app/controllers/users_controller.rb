class UsersController < ApplicationController

 	def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Persona Almacenada.' }
        #format.json { render action: 'show', status: :created, location: @persona }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private 
    def user_params
      params.require(:user).permit(:username, :password)
    end

end
