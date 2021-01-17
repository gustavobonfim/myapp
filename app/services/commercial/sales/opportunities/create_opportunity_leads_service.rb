class Commercial::Sales::Opportunities::CreateOpportunityLeadsService

  def initialize(date_id, opportunity_id, lead_id)
    
    @lead = ::Commercial::Sales::Opportunities::LeadRepository.build(date_id, opportunity_id, lead_id)

  end

  def save_lead

    if @lead.valid?
      @lead.save
      ::Commercial::Sales::Opportunities::UpdateOpportunityService.new(@lead.opportunity).update_opportunity
    end
    
  end
  
end