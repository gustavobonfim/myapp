class Financials::Books::Contracts::CalculationRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    
    return obj
  end

  def self.all_active
    entity.where(active: true)
  end

  def self.all_active_by_date(date_id)
    entity.where(active: true, date_id: date_id)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.find_by_date_and_taker(date_id, taker_id)
    entity.where(date_id: date_id, taker_id: taker_id).first
  end

  def self.read(payable)
    mapper.map(payable)
  end
  
  def self.list(payables)
    mapper.map_all(payables)
  end 
  

  private

  def self.entity
    "Financial::Book::Contract::Calculation".constantize
  end

  def self.mapper
    "Financials::Books::Contracts::CalculationMapper".constantize
  end

end