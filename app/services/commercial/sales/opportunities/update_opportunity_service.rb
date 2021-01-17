class Commercial::Sales::Opportunities::UpdateOpportunityService

  def initialize(opportunity)
    
    @opportunity = opportunity
    
  end

  def update_opportunity

    leads = @opportunity.leads
    products = @opportunity.products

    @opportunity.total_leads = leads.count
    @opportunity.total_amount = products.sum(:amount)

  end
  
end