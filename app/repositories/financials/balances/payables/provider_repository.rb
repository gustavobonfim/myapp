class Financials::Balances::Payables::ProviderRepository < Base

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

  def self.read(provider)
    mapper.map(provider)
  end
  
  def self.list(providers)
    mapper.map_all(providers)
  end
  

  private

  def self.entity
    "Financial::Balance::Payable::Provider".constantize
  end

  def self.mapper
    "Financials::Balances::Payables::ProviderMapper".constantize
  end

  ENUM_TYPE = {
                "individual" => "Pessoa Física",
                "legal" => "Pessoa Jurídica"
              }

end