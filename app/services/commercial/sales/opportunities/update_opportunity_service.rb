class Commercial::Sales::Opportunities::UpdateOpportunityService

  def initialize(obj)
    
    @obj = obj
    @opportunity = @obj.opportunity
    
  end

  def update_opportunity
    obj_class = @obj.class

    if obj_class.name == "Commercial::Sale::Opportunity::Journey"

      journey = ::Commercial::Sales::Opportunities::JourneyRepository.all_active_by_opportunity(@opportunity.id).first
      @opportunity.stage = journey.stage if journey

    elsif obj_class.name == "Commercial::Sale::Opportunity::Lead"

      @opportunity.total_leads = ::Commercial::Sales::Opportunities::LeadRepository.all_active_by_opportunity(@opportunity.id).count

    elsif obj_class.name == "Commercial::Sale::Opportunity::Product"

      @opportunity.total_amount = ::Commercial::Sales::Opportunities::ProductRepository.all_active_by_opportunity(@opportunity.id).sum(:amount)
      @opportunity.total_gain = ::Commercial::Sales::Opportunities::ProductRepository.all_active_by_opportunity(@opportunity.id).sum(:gain)

    elsif obj_class.name == "Commercial::Sale::Opportunity::Ticket"

      @opportunity.total_tickets = ::Commercial::Sales::Opportunities::TicketRepository.all_active_by_opportunity(@opportunity.id).count
      @opportunity.total_calls = ::Commercial::Sales::Opportunities::TicketRepository.all_active_by_opportunity(@opportunity.id).where(kind: obj_class.kinds[:call]).count
      @opportunity.total_contacts = ::Commercial::Sales::Opportunities::TicketRepository.all_active_by_opportunity(@opportunity.id).where("kind = ? OR kind = ? OR kind = ?", obj_class.kinds[:call], obj_class.kinds[:message], obj_class.kinds[:email]).count
      # @opportunity.total_in_process = ::Commercial::Sales::Opportunities::TicketRepository.all_active_by_opportunity(@opportunity.id).where(stage: obj_class.kinds[:in_process]).count

    end

    
    
    @opportunity.save

    ::Commercial::Config::UpdateCalculationService.new(@opportunity.date).update_calculation

  end
  
end