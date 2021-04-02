class Financials::Balances::Payables::ProviderMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "id_type_pretty" => Financials::Balances::Payables::ProviderRepository::ENUM_TYPE[model.id_type] })

    return obj
  end

end