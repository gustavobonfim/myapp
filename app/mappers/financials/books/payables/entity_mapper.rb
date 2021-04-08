class Financials::Books::Payables::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes
    med = model.med

    obj = obj.merge({ "method_pretty" => Financials::Books::Payables::EntityRepository::ENUM_METHOD[model.method] })
    obj = obj.merge({ "due_date_pretty" => DateDecorator.abbr_month_date(model.due_date) })
    obj = obj.merge({ "accrual_date_pretty" => DateDecorator.abbr_month_date(model.accrual_date) })
    obj = obj.merge({ "med_name" => med.name })

    return obj
  end

end