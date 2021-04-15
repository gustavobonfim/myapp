class Financials::Config::DateMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "name" => "Competência #{DateDecorator.abbr_with_month_year(model.month, model.year)}" })
    obj = obj.merge({ "short_name" => DateDecorator.abbr_with_month_year(model.month, model.year) })

    return obj
  end

end