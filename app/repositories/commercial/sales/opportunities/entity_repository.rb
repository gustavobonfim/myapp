class Commercial::Sales::Opportunities::EntityRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    obj.token = set_token("token").upcase
    
    return obj
  end

  def self.find_and_change(attrs)
    obj = entity.find_by(id: attrs["id"])
    obj.attributes = attrs

    return obj
  end

  def self.all_active
    # entity.where(active: true).includes(:leads, :products, :journeys).order(name: :asc)
    entity.where(active: true).order(name: :asc)
  end

  def self.all_active_prospecting
    entity.where(active: true).where("stage = ? OR stage = ? OR stage = ?", entity.stages["prospecting"], entity.stages["qualification"], entity.stages["booking"]).order(name: :asc)
  end

  def self.all_active_closing
    entity.where(active: true).where("stage = ? OR stage = ? OR stage = ?", entity.stages["meeting"], entity.stages["proposal"], entity.stages["closing"]).order(name: :asc)
  end

  def self.all_active_date(date_id)
    entity.where(active: true, date_id: date_id).order(name: :asc)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_token(token)
    entity.find_by(token: token)
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
    "Commercial::Sale::Opportunity::Entity".constantize
  end

  def self.mapper
    "Commercial::Sales::Opportunities::EntityMapper".constantize
  end

  ENUM_STAGE = {
                  "prospecting" => "Prospecção",
                  "qualification" => "Qualificação",
                  "booking" => "Agendamento",
                  "meeting" => "Consultoria",
                  "proposal" => "Proposta",
                  "closing" => "Fechamento",
                  "gain" => "Ganho",
                  "lost" => "Perdido",
                }

  ENUM_STATUS = {
                  "hot" => "Quente",
                  "warn" => "Morno",
                  "cold" => "Frio",
                }

  ENUM_SOURCE = {
                  "base" => "Base",
                  "referrer" => "Indicação",
                  "landing" => "Landing",
                  "event" => "Evento",
                }

end