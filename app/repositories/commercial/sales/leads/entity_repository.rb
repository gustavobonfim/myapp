class Commercial::Sales::Leads::EntityRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    obj.token = set_token("token")
    
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

  def self.all_active_date(date_id)
    entity.where(active: true, date_id: date_id).order(name: :asc)
  end

  def self.read(lead)
    mapper.map(lead)
  end
  
  def self.list(leads)
    mapper.map_all(leads)
  end
  

  private

  def self.set_token(field)
      token = Base.generate_token
      set_token if valid_field(field, token)
      token
    end

  def self.entity
    "Commercial::Sale::Lead::Entity".constantize
  end

  def self.mapper
    "Commercial::Sales::Leads::EntityMapper".constantize
  end

  ENUM_STATUS = {
                  "not_contact" => "Não Contactado",
                  "in_process" => "Em Processo",
                  "gain" => "Ganho",
                  "lost" => "Perdido",
                }

  ENUM_SOURCE = {
                  "base" => "Base",
                  "landing" => "Site",
                  "referrer" => "Indicação",
                  "event" => "Evento",
                }

end