class Financials::Books::Statements::TransactionMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "method_pretty" => Financials::Books::Statements::TransactionRepository::ENUM_METHOD[model.method] })

    return obj
  end

end