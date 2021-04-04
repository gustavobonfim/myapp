class Financials::Books::Payables::EntityRepository < Base

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

  def self.read(payable)
    mapper.map(payable)
  end
  
  def self.list(payables)
    mapper.map_all(payables)
  end 
  

  private

  def self.entity
    "Financial::Book::Payable::Entity".constantize
  end

  def self.mapper
    "Financials::Books::Payables::EntityMapper".constantize
  end

end