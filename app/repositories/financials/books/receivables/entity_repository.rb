class Financials::Books::Receivables::EntityRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    # obj.token = set_token("token").upcase
    
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

  def self.all_active_by_date_and_contract(date_id, contract_id)
    entity.where(active: true, date_id: date_id, contract_id: contract_id)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.read(receivable)
    mapper.map(receivable)
  end
  
  def self.list(receivables)
    mapper.map_all(receivables)
  end

  def self.clean_database
    # Financials::Books::Receivables::EntityRepository.clean_database

    if Rails.env == "development"
      Financial::Book::Receivable::Entity.all.each do |receivable|
        Financial::Book::Transaction::Entity.where(token_tree: receivable.token).destroy_all

        receivable.destroy
      end
    end    
  end
  
  private

  def self.entity
    "Financial::Book::Receivable::Entity".constantize
  end

  def self.mapper
    "Financials::Books::Receivables::EntityMapper".constantize
  end

  def self.set_token(field)
    token = Base.generate_token
    set_token if valid_field(field, token)
    token
  end

  ENUM_STATUS = {
                  "pending" => "Pendente",
                  "received" => "Recebido"
                }

  ENUM_METHOD = {
                  "bank_split" => "Boleto Bancário",
                  "credit_card" => "Cartão de Crédito",
                  "transfer" => "Transferência",
                  "pix" => "PIX",
                }

  ENUM_KIND = {
                "income" => "Mensalidade",
                "refund" => "Reembolso",
                "discount" => "Desconto",
                "reversal" => "Estorno",
              }

end