class HospitalizacionsController < ApplicationController
	before_filter :require_login
	before_action :find_user, :only => [:show]
	# before_filter :is_admin_or_enfermera_enfermeria, :only => [:index]
	before_filter :is_editable, :only => [:edit, :update]
	before_filter :find_hospitalizacion, :only => [:edit, :update, :show, :dar_de_alta]

	def index
		@todos =  Hospitalizacion.all
    respond_to do |format|
      format.html
      format.json { render json: HospitalizacionsDatatable.new(view_context) }
      format.js
    end
  end

	def new
		@hospitalizacion = Hospitalizacion.new
		@hospitalizacion.item_hospitalizacions.build
		@hospitalizacion.build_cliente
	end

	def create
		@hospitalizacion = Hospitalizacion.new(hospitalizacion_params.merge(user_id: current_user.id))
		if @hospitalizacion.save
			redirect_to hospitalizacions_path, :notice => "Almacenado"
		else
			render action: 'new'
		end
	end

	def edit
	end

	def update
		if @hospitalizacion.update(hospitalizacion_params)
			redirect_to hospitalizacions_path, :notice => "Actualizado"
		else
			render action: "edit"
		end
	end

	def show
		@item = ItemHospitalizacion.new
		@items = @hospitalizacion.item_hospitalizacions
		respond_to do |format|
			format.html
			format.js{ render "show" }
			format.pdf do
				render :pdf => "hospitalizacion", :layout => 'report.html', :template => "hospitalizacions/hospitalizacion_pdf.html.erb"
			end
		end
	end

	def dar_de_alta
		unless @hospitalizacion.dado_de_alta
			@hospitalizacion.dado_de_alta = true
			@hospitalizacion.save
			redirect_to hospitalizacions_path, :notice => "Dado de alta!"
		else
			redirect_to hospitalizacions_path, :notice => "Ya fue dado de alta anteriormente"
		end
	end

	private

	def hospitalizacion_params
		params.require(:hospitalizacion).permit :fecha_emision,
		:numero,
		:subtotal,
		:descuento,
		:iva,
		:total,
		:user_id,
		:cliente_id,
		:cliente_attributes => [
			:id,
			:nombre,
			:direccion,
			:telefono,
			:numero_de_identificacion
		],
		:item_hospitalizacions_attributes => [
			:id,
			:cantidad,
			:iva,
			:valor_unitario,
			:subtotal,
			:total,
			:ingreso_producto_id
		]
	end

	def find_hospitalizacion
		@hospitalizacion = Hospitalizacion.find(params[:id])
	end

	def is_editable
		@hospitalizacion = Hospitalizacion.find(params[:id])
		if @hospitalizacion.dado_de_alta
			redirect_to hospitalizacions_path, :notice => "Ya se ha dado de alta! No es posible editar"
		end
	end

	def find_user
		if current_user.rol == Rol.administrador_farmacia or current_user.rol == Rol.vendedor
			@permiso =  false
		else
			@permiso = true
		end
	end
end
