class Financials::Books::Transactions::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "method_pretty" => Financials::Books::Transactions::EntityRepository::ENUM_METHOD[model.method] })
    obj = obj.merge({ "kind_pretty" => Financials::Books::Transactions::EntityRepository::ENUM_KIND[model.kind] })
    obj = obj.merge({ "source_pretty" => Financials::Books::Transactions::EntityRepository::ENUM_SOURCE[model.source] })
    obj = obj.merge({ "from_name_pretty" => model.from.chart_name })
    obj = obj.merge({ "to_name_pretty" => model.to.chart_name })


    return obj
  end

end