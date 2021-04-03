class Financials::Books::Settings::ChannelMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "kind_pretty" => Financials::Books::Settings::ChannelRepository::ENUM_KIND[model.kind] })

    return obj
  end

end