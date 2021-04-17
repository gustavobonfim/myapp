class Financials::Books::Receivables::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes
    med = model.med

    obj = obj.merge({ "method_pretty" => Financials::Books::Receivables::EntityRepository::ENUM_METHOD[model.method] })
    obj = obj.merge({ "kind_pretty" => Financials::Books::Receivables::EntityRepository::ENUM_KIND[model.kind] })
    obj = obj.merge({ "status_pretty" => ::Financials::Books::Receivables::EntityRepository::ENUM_STATUS[model.status] })
    obj = obj.merge({ "due_date_pretty" => DateDecorator.abbr_month_date(model.due_date) })
    obj = obj.merge({ "received_date_pretty" => DateDecorator.abbr_month_date(model.received_date) }) if model.received_date
    obj = obj.merge({ "received_span" => model.received_date ? (model.received_date - model.due_date).to_i : 0 })
    obj = obj.merge({ "med_name" => med.name })

    return obj
  end

end