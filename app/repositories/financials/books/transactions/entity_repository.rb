class Financials::Books::Transactions::EntityRepository < Base

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

  def self.all_active_by_date(date_id)
    entity.where(active: true, date_id: date_id)
  end

  def self.all_active_by_date_and_med_and_from(date_id, med_id, from_id)
    entity.where(active: true, date_id: date_id, med_id: med_id, from_id: from_id)
  end

  def self.all_active_by_date_and_med_and_to(date_id, med_id, to_id)
    entity.where(active: true, date_id: date_id, med_id: med_id, to_id: to_id)
  end

  def self.all_active_by_date_and_chart(date_id, chart_id)
    entity.where(active: true, date_id: date_id).where("from_id == ? OR to_id == ?", chart_id, chart_id)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.read(transaction)
    mapper.map(transaction)
  end
  
  def self.list(transactions)
    mapper.map_all(transactions)
  end
  

  private

  def self.entity
    "Financial::Book::Transaction::Entity".constantize
  end

  def self.mapper
    "Financials::Books::Transactions::EntityMapper".constantize
  end

  ENUM_KIND = {
                "statement" => "Resultado",
                "balance" => "Patrimonial",
              }

  ENUM_METHOD = {
                  "bank_split" => "Boleto Bancário",
                  "credit_card" => "Cartão de Crédito",
                  "transfer" => "Transferência",
                  "pix" => "PIX",
                }

end