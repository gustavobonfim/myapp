class Financials::Books::Payables::EntityRepository < Base

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

  def self.clean_database
    # Financials::Books::Payables::EntityRepository.clean_database

    if Rails.env == "development"
      Financial::Book::Payable::Entity.all.each do |payable|
        Financial::Book::Transaction::Entity.where(token_tree: payable.token).destroy_all

        payable.destroy
      end
    end    
  end
  
  

  private

  def self.entity
    "Financial::Book::Payable::Entity".constantize
  end

  def self.mapper
    "Financials::Books::Payables::EntityMapper".constantize
  end

  def self.set_token(field)
    token = Base.generate_token
    set_token if valid_field(field, token)
    token
  end

  ENUM_METHOD = {
                  "bank_split" => "Boleto Bancário",
                  "credit_card" => "Cartão de Crédito",
                  "transfer" => "Transferência",
                  "pix" => "PIX",
                }

end