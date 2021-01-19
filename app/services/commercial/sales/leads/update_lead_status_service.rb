class Commercial::Sales::Leads::UpdateLeadStatusService

  def initialize(lead_id, new_status)
    
    @lead = ::Commercial::Sales::Leads::EntityRepository.find_by_id(lead_id)
    @new_status = new_status

  end

  def update_lead

    @lead.status = @new_status
    
    @lead.save
  end
  
end