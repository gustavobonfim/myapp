class Commercial::Sales::Opportunities::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "status_pretty" => ::Commercial::Sales::Opportunities::EntityRepository::ENUM_STATUS[model.status] })
    obj = obj.merge({ "source_pretty" => ::Commercial::Sales::Opportunities::EntityRepository::ENUM_SOURCE[model.source] })

    return obj
  end

end