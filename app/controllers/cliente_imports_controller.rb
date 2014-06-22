class ClienteImportsController < ApplicationController
  before_filter :require_login

  def new
    @clienteimport = ClienteImport.new
  end
  
  def create
    @clienteimport = ClienteImport.new(clientes_import_params)
    if @clienteimport.save
      redirect_to clientes_path, :notice => "Clientes importados"
    else
      render :new
    end
  end

  private

  def clientes_import_params
    params.require(:cliente_import).permit(:file)
  end
end
