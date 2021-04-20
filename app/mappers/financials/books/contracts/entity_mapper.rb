class Financials::Books::Contracts::EntityMapper < BaseMapper

  def self.map(model)    
    obj = model.attributes
    taker = model.taker
    med = model.med
    channel = model.channel

    obj = obj.merge({ "product_name_pretty" => ::Financials::Books::Contracts::EntityRepository::ENUM_PRODUCT_NAME[model.product_name] })
    obj = obj.merge({ "product_service_pretty" => ::Financials::Books::Contracts::EntityRepository::ENUM_PRODUCT_SERVICE[model.product_service] })
    obj = obj.merge({ "product_kind_pretty" => ::Financials::Books::Contracts::EntityRepository::ENUM_PRODUCT_KIND[model.product_kind] })
    obj = obj.merge({ "kind_pretty" => ::Financials::Books::Contracts::EntityRepository::ENUM_KIND[model.kind] })
    obj = obj.merge({ "plan_pretty" => ::Financials::Books::Contracts::EntityRepository::ENUM_PLAN[model.plan] })
    obj = obj.merge({ "status_pretty" => ::Financials::Books::Contracts::EntityRepository::ENUM_STATUS[model.status] })
    obj = obj.merge({ "start_month_pretty" => ::DateDecorator::MONTH_PRETTY_SHORT[model.start_month.to_s] })
    obj = obj.merge({ "started_at_pretty" => ::DateDecorator.abbr_month_date(model.started_at) }) if model.started_at
    obj = obj.merge({ "taker_name" => taker.name })
    obj = obj.merge({ "med_name" => med.name })
    obj = obj.merge({ "channel_name" => channel.name })

    return obj
  end

end