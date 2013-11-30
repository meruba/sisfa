class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

 	def new
  	@user = User.new
    @user.build_cliente
  end

  def create
    @user = User.new(user_params) 
      if @user.save
        # redirect_to(:controller => 'clientes', :action => 'new')
        redirect_back_or_to(users_path, notice: "Nuevo Usuario")
        flash[:success] = "Nuevo Usuario.."
      else
        flash[:error] = "Ups! Algo salio mal.."
      end
  end

  private 
    def user_params
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

end

