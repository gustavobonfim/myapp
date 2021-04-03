class Financials::Balances::Payables::EntityRepository < Base

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

  def self.read(payable)
    mapper.map(payable)
  end
  
  def self.list(payables)
    mapper.map_all(payables)
  end
  

  private

  def self.entity
    "Financial::Balance::Payable::Entity".constantize
  end

  def self.mapper
    "Financials::Balances::Payables::EntityMapper".constantize
  end

  ENUM_METHOD = {
                  "bank_split" => "Boleto Bancário",
                  "credit_card" => "Cartão de Crédito",
                  "transfer" => "Transferência",
                  "pix" => "PIX",
                }

end