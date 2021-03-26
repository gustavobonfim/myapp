class Users::Works::Activities::TicketMapper < ::BaseMapper

  def self.map(model)
    obj = model.attributes
    # model_comments = ::Users::Works::Activities::TicketRepository.active_comments(model)

    obj = obj.merge({ "started_at_pretty" => "#{model.started_at.day}/#{I18n.t("date.abbr_month_names")[model.started_at.month]}/#{model.started_at.year}"}) if model.started_at
    obj = obj.merge({ "due_at_pretty" => "#{model.due_at.day}/#{I18n.t("date.abbr_month_names")[model.due_at.month]}/#{model.due_at.year}"}) if model.due_at
    obj = obj.merge({ "due_at_to_time" => model.due_at.to_time.to_i }) if model.due_at
    obj = obj.merge({ "due_at_day" => model.due_at.day }) if model.due_at
    obj = obj.merge({ "due_at_month" => model.due_at.month }) if model.due_at
    obj = obj.merge({ "due_at_year" => model.due_at.year }) if model.due_at
    obj = obj.merge({ "status_pretty" => Users::Works::Activities::TicketRepository::ENUM_STATUS[model.status] })
    obj = obj.merge({ "stage_pretty" => Users::Works::Activities::TicketRepository::ENUM_STAGE[model.stage] })
    obj = obj.merge({ "sharing_pretty" => Users::Works::Activities::TicketRepository::ENUM_SHARING[model.sharing] })
    obj = obj.merge({ "term_pretty" => Users::Works::Activities::TicketRepository::ENUM_TERM[model.term] })
    obj = obj.merge({ "priority_pretty" => Users::Works::Activities::TicketRepository::ENUM_PRIORITY[model.priority] })
    obj = obj.merge({ "kind_pretty" => Users::Works::Activities::TicketRepository::ENUM_KIND[model.kind] })
    # obj = obj.merge({ "comments" =>  model_comments[:comments] })
    # obj = obj.merge({ "total_comments" =>  model_comments[:total_comments] })

    return obj
  end

  def self.map_broadcast(model)
    obj = {}
    model_comments = ::Users::Works::Activities::TicketRepository.active_comments_broadcast(model)

    obj = obj.merge({ "id" => model.id })
    obj = obj.merge({ "active" => model.active })
    obj = obj.merge({ "board_id" => model.board_id })
    obj = obj.merge({ "board_type" => model.board_type })
    obj = obj.merge({ "board_name" => model.board_name })
    obj = obj.merge({ "date_id" => model.date_id })
    obj = obj.merge({ "date_type" => model.date_type })
    obj = obj.merge({ "owner_id" => model.owner_id })
    obj = obj.merge({ "owner_name" => model.owner_name })
    obj = obj.merge({ "performer_id" => model.performer_id })
    obj = obj.merge({ "performer_name" => model.performer_name })
    obj = obj.merge({ "body" => model.body })
    obj = obj.merge({ "started_at" => model.started_at.to_s })
    obj = obj.merge({ "due_at" => model.due_at.to_s })
    obj = obj.merge({ "finished_at" => model.finished_at.to_s })
    obj = obj.merge({ "duration" => model.duration })
    obj = obj.merge({ "stage" => model.stage })
    obj = obj.merge({ "status" => model.status })
    obj = obj.merge({ "flag" => model.flag })
    obj = obj.merge({ "term" => model.term })
    obj = obj.merge({ "sharing" => model.sharing })
    obj = obj.merge({ "priority" => model.priority })
    obj = obj.merge({ "span" => model.span })
    obj = obj.merge({ "started_at_pretty" => "#{model.started_at.day}/#{I18n.t("date.abbr_month_names")[model.started_at.month]}/#{model.started_at.year}"}) if model.started_at
    obj = obj.merge({ "due_at_pretty" => "#{model.due_at.day}/#{I18n.t("date.abbr_month_names")[model.due_at.month]}/#{model.due_at.year}"}) if model.due_at
    obj = obj.merge({ "due_at_to_time" => model.due_at.to_time.to_i }) if model.due_at
    obj = obj.merge({ "due_at_day" => model.due_at.day }) if model.due_at
    obj = obj.merge({ "due_at_month" => model.due_at.month }) if model.due_at
    obj = obj.merge({ "due_at_year" => model.due_at.year }) if model.due_at
    obj = obj.merge({ "status_pretty" => Users::Works::Activities::TicketRepository::ENUM_STATUS[model.status] })
    obj = obj.merge({ "stage_pretty" => Users::Works::Activities::TicketRepository::ENUM_STAGE[model.stage] })
    obj = obj.merge({ "sharing_pretty" => Users::Works::Activities::TicketRepository::ENUM_SHARING[model.sharing] })
    obj = obj.merge({ "term_pretty" => Users::Works::Activities::TicketRepository::ENUM_TERM[model.term] })
    obj = obj.merge({ "priority_pretty" => Users::Works::Activities::TicketRepository::ENUM_PRIORITY[model.priority] })
    obj = obj.merge({ "kind_pretty" => Users::Works::Activities::TicketRepository::ENUM_KIND[model.kind] })
    obj = obj.merge({ "comments" =>  model_comments[:comments] })
    obj = obj.merge({ "total_comments" =>  model_comments[:total_comments] })

    return obj
  end

end