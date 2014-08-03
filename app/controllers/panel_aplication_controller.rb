class PanelAplicationController < ApplicationController
	before_filter :require_login
	before_action :only_admins
	
	def index		
	end

	private
	#get access views as admin
	def only_admins
		if current_user.rol == Rol.administrador or current_user.rol == Rol.administrador_farmacia or current_user.rol == Rol.administrador_estadistica
			@admin =  true
		end
	end
end
