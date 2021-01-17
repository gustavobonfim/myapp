class Commercial::Sales::Opportunities::LeadRepository < Base

  def self.build(date_id, opportunity_id, lead_id)
    obj = entity.new
    obj.date_id = date_id
    obj.opportunity_id = opportunity_id
    obj.lead_id = lead_id
    
    return obj
  end

  def self.find_and_change(attrs)
    obj = entity.find_by(id: attrs["id"])
    obj.attributes = attrs

    return obj
  end

  def self.all_active
    entity.where(active: true).order(lead_name: :asc)
  end

  def self.read(lead)
    mapper.map(lead)
  end
  
  def self.list(leads)
    mapper.map_all(leads)
  end
  

  private

  def self.entity
    "Commercial::Sale::Opportunity::Lead".constantize
  end

  def self.mapper
    "Commercial::Sales::Opportunities::LeadMapper".constantize
  end

  ENUM_INTERN_SOURCE = {
                          "base" => "Base",
                          "landing" => "Site",
                          "referrer" => "Indicação",
                          "event" => "Evento",
                        }


end