class Financials::Books::Receivables::AdjustmentRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    obj.description = "#{ENUM_KIND_DESCRIPTION[attrs["kind"]]} | #{attrs["description"]}"
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

  private

  def self.entity
    "Financial::Book::Receivable::Adjustment".constantize
  end

  def self.mapper
    "Financials::Books::Receivables::AdjustmentMapper".constantize
  end

  def self.set_token(field)
    token = Base.generate_token
    set_token if valid_field(field, token)
    token
  end

  ENUM_KIND_DESCRIPTION = {
                            "refund" => "Reembolso de Despesas",
                            "discount" => "Desconto Contratual",
                            "reversal" => "Estorno de Valores",
                            "error" => "Erro Operacional",
                          }

  ENUM_KIND = {
                "refund" => "Reembolso",
                "discount" => "Desconto",
                "reversal" => "Estorno",
                "error" => "Erro Operacional",
              }

end