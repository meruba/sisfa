class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def find_producto_for_kardex
    unless @producto = Producto.find(params[:producto_id])
      redirect_to productos_path
    end
  end

  protected

  def not_authenticated
  	redirect_to login_url, :alert => "Necesitas Iniciar Sesión"
  end

  def suspendido
    if current_user.suspendido
        logout
        redirect_to login_path
        flash[:error] = "Usuario suspendido"
    end
  end
end
