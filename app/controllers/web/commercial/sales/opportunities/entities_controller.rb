class Web::Commercial::Sales::Opportunities::EntitiesController < ApplicationController
  
  
  def index
  end

  def show

    begin
    @opportunity = ::Commercial::Sale::Opportunity::Entity.friendly.find(opportunity_params[:id])

    rescue ActiveRecord::RecordNotFound => e
      redirect_to dashboard_path
    rescue NoMethodError => e
      redirect_to dashboard_path
    end
    
  end

  private

  def opportunity_params
    params.permit(:id)
  end
  

end