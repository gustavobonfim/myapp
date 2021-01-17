class Commercial::Sales::Opportunities::ProductMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "name_pretty" => ::Commercial::Sales::Opportunities::ProductRepository::ENUM_NAME[model.name] })
    obj = obj.merge({ "kind_pretty" => ::Commercial::Sales::Opportunities::ProductRepository::ENUM_KIND[model.kind] })

    return obj
  end

end