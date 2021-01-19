class Web::Commercial::Dashboards::LeadsController < ApplicationController
  
  
  def index
  end


  private

  def product_params
    params.permit(:id)
  end
  

end