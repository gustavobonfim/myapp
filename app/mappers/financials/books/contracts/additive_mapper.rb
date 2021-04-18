class Financials::Books::Contracts::AdditiveMapper < BaseMapper

  def self.map(model)    
    obj = model.attributes

    obj = obj.merge({ "kind_pretty" => ::Financials::Books::Contracts::AdditiveRepository::ENUM_KIND[model.kind] })
    obj = obj.merge({ "date_pretty" => DateDecorator.abbr_month_date(model.date) })

    return obj
  end

end