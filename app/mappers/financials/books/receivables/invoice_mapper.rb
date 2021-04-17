class Financials::Books::Receivables::InvoiceMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "kind_pretty" => Financials::Books::Receivables::InvoiceRepository::ENUM_KIND[model.kind] })
    obj = obj.merge({ "due_date_pretty" => DateDecorator.abbr_month_date(model.due_date) })

    return obj
  end

end