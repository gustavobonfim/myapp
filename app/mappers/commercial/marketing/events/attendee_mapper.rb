class Commercial::Marketing::Events::AttendeeMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "stage_pretty" => ::Commercial::Sales::Opportunities::JourneyRepository::ENUM_STAGE[model.stage] })
    obj = obj.merge({ "date_pretty" => DateDecorator.abbr_month_date(model.date) })

    return obj
  end

  def self.map_lead_gen(model)
    obj = model.attributes

    obj = obj.merge({ "sql" => Commercial::Sale::Lead::Source.where(source_id: model.id, source_type: "event_conversion").first.present? })
    obj = obj.merge({ "created_at_pretty" => DateDecorator.abbr_month_date(model.created_at) })
    obj = obj.merge({ "council_pretty" => "#{model.crm}#{model.crm_state.upcase}" })
    obj = obj.merge({ "source" => "event" })
    obj = obj.merge({ "source_id" => model.id })
    obj = obj.merge({ "source_type" => "event_conversion" })
    obj = obj.merge({ "source_pretty" => "Evento" })

    return obj
  end
  

  def self.map_all_lead_gen(obj_collection)
    obj_collection.map{ |obj| map_lead_gen(obj) }
  end

end