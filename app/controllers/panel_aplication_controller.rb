class PanelAplicationController < ApplicationController
	before_filter :require_login
	before_action :only_super_user
	def index		
	end

	private
	#get access all views as super user
	def only_super_user
		if current_user.rol == Rol.administrador
			@admin =  true
		end
	end
end
