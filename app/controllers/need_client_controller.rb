class NeedClientController < ApplicationController

  def set_cliente
    if params[:factura]
      cliente_attrs = params[:factura].delete :cliente
    else
      if params[:proforma]
        cliente_attrs = params[:proforma].delete :cliente
      else
        if params[:hospitalizacion]
          cliente_attrs = params[:hospitalizacion].delete :cliente
        end
      end
    end
      @cliente = cliente_attrs[:id].present? ? Cliente.update(cliente_attrs[:id],cliente_attrs) : Cliente.create(cliente_attrs)    
  end

end