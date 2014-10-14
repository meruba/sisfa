class ProductImportsController < ApplicationController
  before_action :require_login
  before_filter :is_admin_or_vendedor_farmacia

  def new
    @productimport = ProductImport.new
  end

  def create
    @productimport = ProductImport.new(productos_import_params)
    if @productimport.save
      redirect_to productos_path, :notice => "Productos importados"
    else
      render :new
    end
  end

  private

  def productos_import_params
    params.require(:product_import).permit(:file)
  end
end
