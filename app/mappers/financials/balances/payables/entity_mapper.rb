class Financials::Balances::Payables::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "method_pretty" => Financials::Balances::Payables::EntityRepository::ENUM_METHOD[model.method] })

    return obj
  end

end