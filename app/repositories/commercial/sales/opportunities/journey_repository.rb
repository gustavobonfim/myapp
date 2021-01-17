class Commercial::Sales::Opportunities::JourneyRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    
    return obj
  end

  def self.find_and_change(attrs)
    obj = entity.find_by(id: attrs["id"])
    obj.attributes = attrs

    return obj
  end

  def self.all_active
    entity.where(active: true).order(date: :desc)
  end

  def self.all_active_by_opportunity(opportunity_id)
    entity.where(active: true, opportunity_id: opportunity_id).order(date: :desc)
  end

  def self.read(journey)
    mapper.map(journey)
  end
  
  def self.list(journeys)
    mapper.map_all(journeys)
  end
  

  private

  def self.entity
    "Commercial::Sale::Opportunity::Journey".constantize
  end

  def self.mapper
    "Commercial::Sales::Opportunities::JourneyMapper".constantize
  end

  ENUM_STATUS = {
                  "prospecting" => "Prospecção",
                  "qualification" => "Qualificação",
                  "booking" => "Agendamento",
                  "meeting" => "Consultoria",
                  "proposal" => "Proposta",
                  "gain" => "Ganho",
                  "lost" => "Perdido",
                }

end