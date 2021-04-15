class Financials::Books::Contracts::EntityMapper < BaseMapper

  def self.map(model)    
    obj = model.attributes

    obj = obj.merge({ "product_name_pretty" => ::Financials::Books::Contracts::EntityRepository::ENUM_PRODUCT_NAME[model.product_name] })
    obj = obj.merge({ "product_service_pretty" => ::Financials::Books::Contracts::EntityRepository::ENUM_PRODUCT_SERVICE[model.product_service] })
    obj = obj.merge({ "product_kind_pretty" => ::Financials::Books::Contracts::EntityRepository::ENUM_PRODUCT_KIND[model.product_kind] })
    obj = obj.merge({ "kind_pretty" => ::Financials::Books::Contracts::EntityRepository::ENUM_KIND[model.kind] })
    obj = obj.merge({ "plan_pretty" => ::Financials::Books::Contracts::EntityRepository::ENUM_PLAN[model.plan] })
    obj = obj.merge({ "status_pretty" => ::Financials::Books::Contracts::EntityRepository::ENUM_STATUS[model.status] })
    obj = obj.merge({ "start_month_pretty" => ::DateDecorator::MONTH_PRETTY_SHORT[model.start_month.to_s] })

    return obj
  end

end