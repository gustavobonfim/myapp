class Financials::Books::Receivables::InvoiceMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "status_pretty" => Financials::Books::Receivables::InvoiceRepository::ENUM_STATUS[model.status] })
    obj = obj.merge({ "method_pretty" => Financials::Books::Receivables::InvoiceRepository::ENUM_METHOD[model.method] })
    obj = obj.merge({ "due_date_pretty" => DateDecorator.abbr_month_date(model.due_date) }) if model.due_date

    return obj
  end

end