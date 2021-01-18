class Commercial::Sales::Opportunities::TicketRepository < Base

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
    entity.where(active: true).order(due_at: :desc)
  end

  def self.all_active_by_opportunity(opportunity_id)
    entity.where(active: true, opportunity_id: opportunity_id).order(due_at: :desc)
  end

  def self.read(ticket)
    mapper.map(ticket)
  end
  
  def self.list(tickets)
    mapper.map_all(tickets)
  end
  

  private

  def self.entity
    "Commercial::Sale::Opportunity::Ticket".constantize
  end

  def self.mapper
    "Commercial::Sales::Opportunities::TicketMapper".constantize
  end

  ENUM_STAGE = {
                  "in_process" => "Em Processo",
                  "resolved" => "Resolvido",
                  "canceled" => "Cancelado"
                }

  ENUM_PRIORITY = {
                    "low" => "Baixa",
                    "medium" => "Média",
                    "high" => "Alta",
                    "maximum" => "Máxima"
                  }

  ENUM_TERM = {
                    "quick" => "15 Min",
                    "fast" => "30 Min",
                    "normal" => "1 Hora",
                    "long" => "3 Horas",
                    "large" => "6 Horas"
                  }

  ENUM_STATUS = {
                  "in_time" => "No Prazo",
                  "delay" => "Atrasado",
                }

  ENUM_SHARING = {
                    "internal" => "Interna",
                    "external" => "Médico",
                  }

end