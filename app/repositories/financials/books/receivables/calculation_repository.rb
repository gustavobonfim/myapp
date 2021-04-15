class Financials::Books::Receivables::CalculationRepository < Base

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

  def self.find_by_date_and_med(date_id, med_id)
    entity.where(date_id: date_id, med_id: med_id).first
  end

  def self.read(receivable)
    mapper.map(receivable)
  end
  
  def self.list(receivables)
    mapper.map_all(receivables)
  end 
  

  private

  def self.entity
    "Financial::Book::Receivable::Calculation".constantize
  end

  def self.mapper
    "Financials::Books::Receivables::CalculationMapper".constantize
  end

end