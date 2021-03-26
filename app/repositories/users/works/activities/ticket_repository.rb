class Users::Works::Activities::TicketRepository < Base

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

  def self.all_active_by_board(board_id, board_type)
    entity.where(active: true, board_id: board_id, board_type: board_type).includes(:comments).order(created_at: :asc)
  end

  def self.all_active_by_selects_board(board_ids, board_type)
    entity.where(active: true, board_id: board_ids, board_type: board_type).includes(:comments).order(created_at: :asc)
  end

  def self.all_active_by_board_type(board_type)
    entity.where(active: true, board_type: board_type).includes(:comments).order(created_at: :asc)
  end

  def self.all_active_by_board_and_date(board_id, board_type, date_id, date_type)
    entity.where(active: true, board_id: board_id, board_type: board_type, date_id: date_id, date_type: date_type)
  end

  def self.list_all(tickets)
    mapper.map_all(tickets)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.read(ticket)
    mapper.map(ticket)
  end
  
  def self.list(tickets)
    mapper.map_all(tickets)
  end
  

  private

  def self.entity
    "User::Work::Activity::Ticket".constantize
  end

  def self.mapper
    "Users::Works::Activities::TicketMapper".constantize
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

  ENUM_KIND = {
                    "task" => "Tarefa",
                    "call" => "Ligação",
                    "mail" => "E-mail",
                    "message" => "Mensagem",
                    "document" => "Documento"
                  }

  ENUM_STATUS = {
                  "in_time" => "No Prazo",
                  "delay" => "Atrasado",
                }

  ENUM_SHARING = {
                    "internal" => "Interna",
                    "external" => "Médico",
                  }

  UPDATE_NOTIFICATION = ["active", "process_whom", "process_name", "description", "priority", "stage", "due_date", "started_at", "duration"]
  EXCLUDE_UPDATE = ["body", "priority", "sharing", "term", "status"]

end