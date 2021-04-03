class Financials::Balances::Settings::ChannelMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "kind_pretty" => Financials::Balances::Settings::ChannelRepository::ENUM_KIND[model.kind] })

    return obj
  end

end