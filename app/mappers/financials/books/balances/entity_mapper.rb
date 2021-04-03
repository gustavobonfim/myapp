class Financials::Books::Balances::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes
    chart = model.chart

    obj = obj.merge({ "kind_pretty" => ::Financials::Books::Balances::EntityRepository::ENUM_KIND[model.kind] })
    obj = obj.merge({ "chart.master_name" => chart.master_name })
    obj = obj.merge({ "chart.group" => chart.group })
    obj = obj.merge({ "chart.master_group" => chart.master_group })
    obj = obj.merge({ "chart.master" => chart.master })
    obj = obj.merge({ "master_name_pretty" => ::Financials::Books::Settings::ChartAccountRepository::ENUM_MASTER_NAME[chart.master_name] })
    obj = obj.merge({ "group_pretty" => ::Financials::Books::Settings::ChartAccountRepository::ENUM_GROUP[chart.group] })
    obj = obj.merge({ "master_group_pretty" => ::Financials::Books::Settings::ChartAccountRepository::ENUM_MASTER_GROUP[chart.master_group] })
    obj = obj.merge({ "master_pretty" => ::Financials::Books::Settings::ChartAccountRepository::ENUM_MASTER[chart.master] })

    return obj
  end

end