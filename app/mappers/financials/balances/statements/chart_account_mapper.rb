class Financials::Balances::Statements::ChartAccountMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "master_name_pretty" => Financials::Balances::Statements::ChartAccountRepository::ENUM_MASTER_NAME[model.master_name] })
    obj = obj.merge({ "group_pretty" => Financials::Balances::Statements::ChartAccountRepository::ENUM_GROUP[model.group] })
    obj = obj.merge({ "master_group_pretty" => Financials::Balances::Statements::ChartAccountRepository::ENUM_MASTER_GROUP[model.master_group] })
    obj = obj.merge({ "master_pretty" => Financials::Balances::Statements::ChartAccountRepository::ENUM_MASTER[model.master] })

    return obj
  end

end