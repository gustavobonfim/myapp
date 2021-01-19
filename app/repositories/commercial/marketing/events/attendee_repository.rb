class Commercial::Marketing::Events::AttendeeRepository < Base

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

  def self.read(source)
    mapper.map(source)
  end
  
  def self.lead_gen(sources)
    mapper.map_all_lead_gen(sources)
  end  

  private

  def self.entity
    "Commercial::Marketing::Event::Attendee".constantize
  end

  def self.mapper
    "Commercial::Marketing::Events::AttendeeMapper".constantize
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