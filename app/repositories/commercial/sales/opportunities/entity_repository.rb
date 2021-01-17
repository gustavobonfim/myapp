class Commercial::Sales::Opportunities::EntityRepository < Base

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
    entity.where(active: true).order(name: :asc)
  end

  def self.read(lead)
    mapper.map(lead)
  end
  
  def self.list(leads)
    mapper.map_all(leads)
  end
  

  private

  def self.entity
    "Commercial::Sale::Opportunity::Entity".constantize
  end

  def self.mapper
    "Commercial::Sales::Opportunities::EntityMapper".constantize
  end

  ENUM_INTERN_SOURCE = {
                          "base" => "Base",
                          "landing" => "Site",
                          "referrer" => "Indicação",
                          "event" => "Evento",
                        }


end