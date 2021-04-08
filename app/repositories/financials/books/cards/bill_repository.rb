class Financials::Books::Cards::BillRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    obj.token = set_token("token").upcase
    
    return obj
  end

  def self.find_and_change(attrs)
    obj = entity.find_by(id: attrs["id"])
    obj.attributes = attrs

    return obj
  end

  def self.all_active
    entity.where(active: true).includes(:med)
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

  def self.read(bill)
    mapper.map(bill)
  end
  
  def self.list(bills)
    mapper.map_all(bills)
  end
  
  private

  def self.entity
    "Financial::Book::Card::Bill".constantize
  end

  def self.mapper
    "Financials::Books::Cards::BillMapper".constantize
  end

  def self.set_token(field)
    token = Base.generate_token
    set_token if valid_field(field, token)
    token
  end

  ENUM_INVOICE = {
                    "open" => "Aberta",
                    "closed" => "Fechada",
                    "paid" => "Paga"
                 }

end