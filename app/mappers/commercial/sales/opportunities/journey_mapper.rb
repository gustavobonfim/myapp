class Commercial::Sales::Opportunities::JourneyMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "status_pretty" => ::Commercial::Sales::Opportunities::JourneyRepository::ENUM_STATUS[model.status] })
    obj = obj.merge({ "date_pretty" => DateDecorator.abbr_month_date(model.date) })

    return obj
  end

end