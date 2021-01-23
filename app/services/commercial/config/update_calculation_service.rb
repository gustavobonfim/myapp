class Commercial::Config::UpdateCalculationService

  def initialize(obj)
    
    @date = obj.date
    @calculation = calculation

    if obj.class.name == "Commercial::Sale::Opportunity::Entity"
      @opportunities = opportunities
    elsif obj.class.name == "Commercial::Sale::Lead::Entity"
      @leads = leads
    end

  end

  def update_lead_calculation
    @calculation.marketing_leads = @leads.size

    @calculation.save
  end
  

  def update_opportunity_calculation

    base_opportunities = @opportunities.where(source: "base")
    referrer_opportunities = @opportunities.where(source: "referrer")
    landing_opportunities = @opportunities.where(source: "landing")
    event_opportunities = @opportunities.where(source: "event")
    
    @calculation.sales_leads = @opportunities.sum(:total_leads)
    @calculation.total_amount = @opportunities.sum(:total_amount)
    @calculation.total_gain = @opportunities.sum(:total_gain)

    @calculation.base_leads = base_opportunities.sum(:total_leads)
    @calculation.base_amount = base_opportunities.sum(:total_amount)
    @calculation.base_gain = base_opportunities.sum(:total_gain)
    
    @calculation.referrer_leads = referrer_opportunities.sum(:total_leads)
    @calculation.referrer_amount = referrer_opportunities.sum(:total_amount)
    @calculation.referrer_gain = referrer_opportunities.sum(:total_gain)
    
    @calculation.landing_leads = landing_opportunities.sum(:total_leads)
    @calculation.landing_amount = landing_opportunities.sum(:total_amount)
    @calculation.landing_gain = landing_opportunities.sum(:total_gain)

    @calculation.event_leads = event_opportunities.sum(:total_leads)
    @calculation.event_amount = event_opportunities.sum(:total_amount)
    @calculation.event_gain = event_opportunities.sum(:total_gain)

    @calculation.prospecting_count = @opportunities.where(stage: "prospecting").size
    @calculation.qualification_count = @opportunities.where(stage: "qualification").size
    @calculation.booking_count = @opportunities.where(stage: "booking").size
    @calculation.meeting_count = @opportunities.where(stage: "meeting").size
    @calculation.proposal_count = @opportunities.where(stage: "proposal").size
    @calculation.closing_count = @opportunities.where(stage: "closing").size
    @calculation.gain_count = @opportunities.where(stage: "gain").size
    @calculation.lost_count = @opportunities.where(stage: "lost").size

    @calculation.prospecting_amount = @opportunities.where(stage: "prospecting").sum(:total_amount)
    @calculation.qualification_amount = @opportunities.where(stage: "qualification").sum(:total_amount)
    @calculation.booking_amount = @opportunities.where(stage: "booking").sum(:total_amount)
    @calculation.meeting_amount = @opportunities.where(stage: "meeting").sum(:total_amount)
    @calculation.proposal_amount = @opportunities.where(stage: "proposal").sum(:total_amount)
    @calculation.closing_amount = @opportunities.where(stage: "closing").sum(:total_amount)
    @calculation.gain_amount = @opportunities.where(stage: "gain").sum(:total_amount)
    @calculation.lost_amount = @opportunities.where(stage: "lost").sum(:total_amount)

    @calculation.total_tickets = @opportunities.sum(:total_tickets)
    @calculation.total_calls = @opportunities.sum(:total_calls)
    @calculation.total_contacts = @opportunities.sum(:total_contacts)
    @calculation.total_in_process = @opportunities.sum(:total_in_process)

    @calculation.save

  end

  def calculation
    ::Commercial::Config::CalculationRepository.find_by_date(@date.id)
  end
  
  def opportunities
    ::Commercial::Sales::Opportunities::EntityRepository.all_active_date(@date.id)
  end

  def leads
    ::Commercial::Sales::Leads::EntityRepository.all_active_date(@date.id)
  end
  
  
end