class UsersController < ApplicationController
# before_action :set_user, only: [:show,:edit, :update]  
  
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
  end

  def create
    @user = User.new(current_user_params) 
      if @user.save
        redirect_back_or_to(users_path, notice: "Nuevo Usuario")
      else
        flash[:error] = "Ups! Algo salio mal.."
      end
  end

  private 
    def current_user_params
      params.require(:user).permit :username,
                                    :password,
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
      @user = current_user.find(params[:id])
    end
end

