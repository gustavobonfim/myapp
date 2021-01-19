class Commercial::Marketing::Landings::LeadRepository < Base

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
    entity.where(active: true)
  end

  def self.read(lead)
    mapper.map(lead)
  end
  
  def self.lead_gen(leads)
    mapper.map_all_lead_gen(leads)
  end  

  private

  def self.entity
    "Commercial::Marketing::Landing::Lead".constantize
  end

  def self.mapper
    "Commercial::Marketing::Landings::LeadMapper".constantize
  end

  ENUM_SOURCE = {
                  "base" => "Base",
                  "landing" => "Site",
                  "referrer" => "Indicação",
                  "event" => "Evento",
                }


  SOURCE_TYPE = {
                  "landing_conversion" => "Lead::Entity",
                  "event_conversion" => "Commercial::Marketing::Event::Attendee"
                }

end