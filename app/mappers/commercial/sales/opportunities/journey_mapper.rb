class Commercial::Sales::Opportunities::JourneyMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "stage_pretty" => ::Commercial::Sales::Opportunities::JourneyRepository::ENUM_STAGE[model.stage] })
    obj = obj.merge({ "date_pretty" => DateDecorator.abbr_month_date(model.date) })
    obj = obj.merge({ "period" => Date.current.day - model.date.day })
    obj = obj.merge({ "stage_alert" => Date.current.day - model.date.day > 4 ? true : false })

    return obj
  end

  def self.map_with_next(model, next_model)
    obj = model.attributes

    obj = obj.merge({ "stage_pretty" => ::Commercial::Sales::Opportunities::JourneyRepository::ENUM_STAGE[model.stage] })
    obj = obj.merge({ "date_pretty" => DateDecorator.abbr_month_date(model.date) })
    obj = obj.merge({ "period" => next_model.date.day - model.date.day }) if next_model
    # obj = obj.merge({ "stage_alert" => next_model.date.day - model.date.day > 4 ? true : false }) if next_model
    obj = obj.merge({ "stage_alert" => false }) if next_model

    return obj
  end

  def self.map_all_with_next(obj_collection)

    obj_collection = obj_collection.reverse

    obj_collection.each_with_index.map{ |obj, i| obj_collection[i + 1] ? map_with_next(obj, obj_collection[i + 1]) : map(obj) }.reverse
  end

end