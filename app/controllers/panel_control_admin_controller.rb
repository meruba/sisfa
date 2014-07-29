class PanelControlAdminController < ApplicationController
	before_filter :require_login
	before_filter :is_super_user
	def index		
	end
end
