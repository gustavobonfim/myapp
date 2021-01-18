class Commercial::Sales::Opportunities::CreateOpportunityJourneyService

  def initialize(opportunity)
    
    @journey = opportunity.journeys.new
    @journey.stage = opportunity.stage
    @journey.date = opportunity.started_at

  end

  def save_journey

    if @journey.valid?
      @journey.save
    end
    
  end
  
end