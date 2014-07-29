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
  def is_admin_or_auxiliar_estadistica
    permission(Rol.administrador_estadistica, Rol.auxiliar_estadistica)
  end

  def is_admin_or_vendedor_farmacia
    permission(Rol.administrador_farmacia, Rol.vendedor)
  end

  def is_admin_or_enfermera_enfermeria
    permission(Rol.administrador_enfermeria, Rol.enfermera)
  end

  def is_doctor
    unless current_user.rol == Rol.doctor
      logout
      redirect_to login_path
      flash[:error] = "No tienes permiso para eso!"
    end
  end

  def is_super_user
    unless current_user.rol == Rol.administrador
      logout
      redirect_to login_path
      flash[:error] = "No tienes permiso para eso!"
    end
  end

  def shared_permission
    if current_user.rol == Rol.administrador_farmacia or current_user.rol == Rol.vendedor
      logout
      redirect_to login_path
      flash[:error] = "No tienes permiso para eso!"
    else
      if current_user.rol == Rol.administrador_farmacia
        @admin = false
      else
        @admin = true
      end
    end
  end

  private
  def permission(rol_admin, rol_second)
    if current_user.suspendido
      logout
      redirect_to login_path
      flash[:error] = "Usuario suspendido"
    else
      # is admin departament?
      if current_user.rol == rol_second
        @admin = false
      else
        @admin = true
      end
      # Rol.administrador has all permissions
      unless current_user.rol == rol_admin or current_user.rol == rol_second or current_user.rol == Rol.administrador
        logout
        redirect_to login_path
        flash[:error] = "No tienes permiso para eso!"
      end
    end
  end
end
