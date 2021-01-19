class Commercial::Marketing::Landings::LeadMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "stage_pretty" => ::Commercial::Sales::Opportunities::JourneyRepository::ENUM_STAGE[model.stage] })
    obj = obj.merge({ "date_pretty" => DateDecorator.abbr_month_date(model.date) })

    return obj
  end

  def self.map_lead_gen(obj)
    obj = obj.merge({ "sale_lead" => Commercial::Sale::Lead::Source.where(source_id: obj["id"], source_type: "landing_conversion").first.present? })

    return obj
  end
  

  def self.map_all_lead_gen(obj_collection)
    obj_collection.map{ |obj| map_lead_gen(obj.attributes) }
  end

end