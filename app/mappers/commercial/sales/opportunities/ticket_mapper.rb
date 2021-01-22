class Commercial::Sales::Opportunities::TicketMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "stage_pretty" => ::Commercial::Sales::Opportunities::TicketRepository::ENUM_STAGE[model.stage] })
    obj = obj.merge({ "status_pretty" => ::Commercial::Sales::Opportunities::TicketRepository::ENUM_STATUS[model.status] })
    obj = obj.merge({ "due_at_pretty" => "#{model.due_at.day}/#{I18n.t("date.abbr_month_names")[model.due_at.month]}/#{model.due_at.year}" }) if model.due_at
    obj = obj.merge({ "due_at_time" => model.due_at.to_time.to_i }) if model.due_at
    obj = obj.merge({ "date_id" => 2 })

    return obj
  end

end