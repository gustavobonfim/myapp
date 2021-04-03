class Financials::Books::Settings::ChannelRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    
    return obj
  end

  def self.find_and_change(attrs)
    obj = entity.find_by(id: attrs["id"])
    obj.attributes = attrs

    return obj
  end

  def self.all_active
    entity.where(active: true)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.read(channel)
    mapper.map(channel)
  end
  
  def self.list(channels)
    mapper.map_all(channels)
  end
  

  private

  def self.entity
    "Financial::Book::Setting::Channel".constantize
  end

  def self.mapper
    "Financials::Books::Settings::ChannelMapper".constantize
  end

  ENUM_KIND = {
                "bank" => "Banco",
                "credit_card" => "Cartão de Crédito"
              }

end