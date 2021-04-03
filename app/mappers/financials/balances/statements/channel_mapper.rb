class Financials::Balances::Statements::ChannelMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "kind_pretty" => Financials::Balances::Statements::ChannelRepository::ENUM_KIND[model.kind] })

    return obj
  end

end