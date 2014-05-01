class ProductImportsController < ApplicationController
  before_filter :require_login

  def new
    @productimport = ProductImport.new
  end
  
  def create
    @productimport = ProductImport.new(productos_import_params)
    if @productimport.save
      redirect_to productos_path
      flash[:success] = "Productos importados!"
    else
      render :new
    end
  end

  private

  def productos_import_params
    params.require(:product_import).permit(:file)
  end
end
