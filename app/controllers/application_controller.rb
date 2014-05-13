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

  # poner en controlador before_filter :is_admin
  def is_admin
    unless current_user.rol == Rol.administrador
      logout
      redirect_to login_path
      flash[:error] = "No tienes permiso para eso!"
    end
  end

  def is_enfermera
    unless current_user.rol == Rol.enfermera
      logout
      redirect_to login_path
      flash[:error] = "No tienes permiso para eso!"
    end
  end

  def is_vendedor
    unless current_user.rol == Rol.vendedor
      logout
      redirect_to login_path
      flash[:error] = "No tienes permiso para eso!"
    end
  end

  def is_admin_estadistica
    unless current_user.rol == Rol.administrador_estadistica
      logout
      redirect_to login_path
      flash[:error] = "No tienes permiso para eso!"
    end
  end

  def is_admin_farmacia
    unless current_user.rol == Rol.administrador_farmacia
      logout
      redirect_to login_path
      flash[:error] = "No tienes permiso para eso!"
    end
  end

  def is_admin_enfermeria
    unless current_user.rol == Rol.administrador_enfermeria
      logout
      redirect_to login_path
      flash[:error] = "No tienes permiso para eso!"
    end
  end

  def suspendido
    if current_user.suspendido
        logout
        redirect_to login_path
        flash[:error] = "Usuario suspendido"
    end
  end
end
