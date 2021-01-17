class Commercial::Sales::Opportunities::UpdateOpportunityService

  def initialize(opportunity)
    
    @opportunity = opportunity
    
  end

  def update_opportunity

    leads = @opportunity.leads
    products = @opportunity.products

    @opportunity.total_leads = leads.where(active: true).count
    @opportunity.total_amount = products.where(active: true).sum(:amount)
    @opportunity.save

  end
  
end