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

      if @opportunity.stage == "gain"
        @opportunity.total_gain = ::Commercial::Sales::Opportunities::ProductRepository.all_active_by_opportunity(@opportunity.id).sum(:gain)
      end
      if @opportunity.stage == "lost"
        @opportunity.total_lost = ::Commercial::Sales::Opportunities::ProductRepository.all_active_by_opportunity(@opportunity.id).sum(:lost)
      end

    elsif obj_class.name == "Commercial::Sale::Opportunity::Lead"

      @opportunity.total_leads = ::Commercial::Sales::Opportunities::LeadRepository.all_active_by_opportunity(@opportunity.id).count

    elsif obj_class.name == "Commercial::Sale::Opportunity::Product"

      @opportunity.total_amount = ::Commercial::Sales::Opportunities::ProductRepository.all_active_by_opportunity(@opportunity.id).sum(:amount)

    elsif obj_class.name == "Commercial::Sale::Opportunity::Ticket"
      tickets = ::Commercial::Sales::Opportunities::TicketRepository.all_active_by_opportunity(@opportunity.id)

      @opportunity.total_tickets = tickets.count
      @opportunity.total_calls = tickets.where(kind: obj_class.kinds[:call]).count
      @opportunity.total_contacts = tickets.where("kind = ? OR kind = ? OR kind = ?", obj_class.kinds[:call], obj_class.kinds[:message], obj_class.kinds[:email]).count
      @opportunity.total_in_process = tickets.where(stage: obj_class.stages[:in_process]).count

    end

    @opportunity.save

    ::Commercial::Config::UpdateCalculationService.new(@opportunity).update_opportunity_calculation

  end
  
end