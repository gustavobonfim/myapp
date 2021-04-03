class Financials::Books::Transactions::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "method_pretty" => Financials::Books::Transactions::EntityRepository::ENUM_METHOD[model.method] })

    return obj
  end

end