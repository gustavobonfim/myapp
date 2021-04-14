class Financials::Books::Cards::TransactionMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "date" => DateDecorator.abbr_month_date(model.date) })
    obj = obj.merge({ "first_pay" => DateDecorator.abbr_month_date(model.first_pay) })
    obj = obj.merge({ "last_pay" => DateDecorator.abbr_month_date(model.last_pay) })
    obj = obj.merge({ "pay_day" => DateDecorator.abbr_month_date(model.pay_day) })
    obj = obj.merge({ "closing_day" => DateDecorator.abbr_month_date(model.closing_day) })
    

    return obj
  end

end