class Financials::Books::Contracts::TakerRepository < Base

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
    entity.where(active: true).includes(:calculations)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.read(taker)
    mapper.map(taker)
  end
  
  def self.list(takers)
    mapper.map_all(takers)
  end
  

  private

  def self.entity
    "Financial::Book::Contract::Taker".constantize
  end

  def self.mapper
    "Financials::Books::Contracts::TakerMapper".constantize
  end

  ENUM_KIND_TO_SCHEMA = {
                          "individual" => "User::Account::Entity",
                          "legal" => "User::Company::Entity"
                        }

  ENUM_TYPE = {
                "individual" => "Pessoa Física",
                "legal" => "Pessoa Jurídica"
              }

end