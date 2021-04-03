class Financials::Books::Payables::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "method_pretty" => Financials::Books::Payables::EntityRepository::ENUM_METHOD[model.method] })

    return obj
  end

end