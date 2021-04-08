class Financials::Books::Settings::ChartAccountMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "master_name_pretty" => ::Financials::Books::Settings::ChartAccountRepository::ENUM_MASTER_NAME[model.master_name] })
    obj = obj.merge({ "group_pretty" => ::Financials::Books::Settings::ChartAccountRepository::ENUM_GROUP[model.group] })
    obj = obj.merge({ "master_group_pretty" => ::Financials::Books::Settings::ChartAccountRepository::ENUM_MASTER_GROUP[model.master_group] })
    obj = obj.merge({ "master_pretty" => ::Financials::Books::Settings::ChartAccountRepository::ENUM_MASTER[model.master] })
    obj = obj.merge({ "kind_pretty" => ::Financials::Books::Settings::ChartAccountRepository::ENUM_KIND[model.kind] })

    return obj
  end

end