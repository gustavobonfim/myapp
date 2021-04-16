class Financials::Books::Receivables::AdjustmentMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "kind_pretty" => Financials::Books::Receivables::AdjustmentRepository::ENUM_KIND[model.kind] })
    obj = obj.merge({ "due_date_pretty" => DateDecorator.abbr_month_date(model.due_date) })

    return obj
  end

end