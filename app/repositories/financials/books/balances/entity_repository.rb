class Financials::Books::Balances::EntityRepository < Base

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
    entity.where(active: true).includes(:chart)
  end

  def self.all_active_by_date(date_id)
    entity.where(active: true, date_id: date_id).includes(:chart)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_date_and_med(date_id, med_id, chart_id)
    entity.where(date_id: date_id, med_id: med_id, chart_id: chart_id).first
  end

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.find_previous_balance(med_id, chart_id)
    previous = entity.where(active: true, med_id: med_id, chart_id: chart_id).order(token: :desc).first

    if previous.present?
      return previous
    else
      return entity.new
    end
  end

  def self.read(balance)
    mapper.map(balance)
  end
  
  def self.list(balances)
    mapper.map_all(balances)
  end
  

  private

  def self.entity
    "Financial::Book::Balance::Entity".constantize
  end

  def self.mapper
    "Financials::Books::Balances::EntityMapper".constantize
  end

  ENUM_KIND = {
                "statement" => "Resultado",
                "balance" => "Patrimonial",
              }

end