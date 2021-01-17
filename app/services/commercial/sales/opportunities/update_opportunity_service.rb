class Commercial::Sales::Opportunities::UpdateOpportunityService

  def initialize(opportunity)
    
    @opportunity = opportunity
    
  end

  def update_opportunity

    leads = @opportunity.leads
    products = @opportunity.products
    journey = ::Commercial::Sales::Opportunities::JourneyRepository.all_active_by_opportunity(@opportunity.id).first

    @opportunity.total_leads = ::Commercial::Sales::Opportunities::LeadRepository.all_active_by_opportunity(@opportunity.id).count
    @opportunity.total_amount = ::Commercial::Sales::Opportunities::ProductRepository.all_active_by_opportunity(@opportunity.id).sum(:amount)
    @opportunity.status = journey.status if journey
    
    @opportunity.save

    ::Commercial::Config::UpdateCalculationService.new(@opportunity.date).update_calculation

  end
  
end