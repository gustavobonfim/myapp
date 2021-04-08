class Financials::Books::Cards::BillMapper < BaseMapper

  def self.map(model)
    obj = model.attributes
    med = model.med

    obj = obj.merge({ "due_date" => DateDecorator.abbr_month_date(model.due_date) })
    obj = obj.merge({ "closing_date" => DateDecorator.abbr_month_date(model.closing_date) })
    obj = obj.merge({ "invoice_pretty" => Financials::Books::Cards::EntityRepository::ENUM_INVOICE[model.invoice] })

    return obj
  end

end