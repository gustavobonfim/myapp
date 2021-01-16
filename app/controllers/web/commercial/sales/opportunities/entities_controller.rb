class Web::Commercial::Sales::Opportunities::EntitiesController < ApplicationController
  
  
  def index
  end

  def show

    begin
      @booking = ::Operation::Product::Entity.friendly.find(product_params[:id].downcase)

    rescue ActiveRecord::RecordNotFound => e
      redirect_to dashboard_path
    rescue NoMethodError => e
      redirect_to dashboard_path
    end
    
  end

  private

  def product_params
    params.permit(:id)
  end
  

end