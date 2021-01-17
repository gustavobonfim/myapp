class Commercial::Sales::Opportunities::UpdateOpportunityService

  def initialize(opportunity)
    
    @opportunity = opportunity
    
  end

  def update_opportunity

    leads = @opportunity.leads
    products = @opportunity.products

    @opportunity.total_leads = ::Commercial::Sales::Opportunities::LeadRepository.all_active_by_opportunity(@opportunity.id).count
    @opportunity.total_amount = ::Commercial::Sales::Opportunities::ProductRepository.all_active_by_opportunity(@opportunity.id).sum(:amount)
    @opportunity.status = ::Commercial::Sales::Opportunities::JourneyRepository.all_active_by_opportunity(@opportunity.id).first.status
    
    @opportunity.save

  end
  
end