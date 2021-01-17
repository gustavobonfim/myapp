class Commercial::Config::UpdateCalculationService

  def initialize(date)
    
    @date = date
    @calculation = calculation
    @opportunities = opportunities

  end

  def update_calculation

    base_opportunities = @opportunities.where(source: "base")
    referrer_opportunities = @opportunities.where(source: "referrer")
    landing_opportunities = @opportunities.where(source: "landing")
    event_opportunities = @opportunities.where(source: "event")
    
    @calculation.total_leads = @opportunities.sum(:total_leads)
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

    @calculation.save

  end

  def calculation
    ::Commercial::Config::CalculationRepository.find_by_date(@date.id)
  end
  
  def opportunities
    ::Commercial::Sales::Opportunities::EntityRepository.all_active_date(@date.id)
  end
  
  
end