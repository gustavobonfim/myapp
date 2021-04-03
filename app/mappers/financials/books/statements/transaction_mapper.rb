class Financials::Books::Statements::CalculationMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "method_pretty" => Financials::Books::Statements::CalculationRepository::ENUM_METHOD[model.method] })

    return obj
  end

end