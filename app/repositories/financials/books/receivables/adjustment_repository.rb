class Financials::Books::Receivables::AdjustmentRepository < Base

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

  def self.all_active_by_date(date_id)
    entity.where(active: true, date_id: date_id)
  end

  def self.all_active_by_date_and_med(date_id, med_id)
    entity.where(date_id: date_id, med_id: med_id)
  end

  def self.all_active_by_date_and_contract(date_id, contract_id)
    entity.where(active: true, date_id: date_id, contract_id: contract_id)
  end

  def self.all_active_by_date_and_contracts(date_id, contract_ids)
    entity.where(active: true, date_id: date_id, contract_id: contract_ids)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.read(adjustment)
    mapper.map(adjustment)
  end
  
  def self.list(adjustments)
    mapper.map_all(adjustments)
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

  ENUM_STATUS = {
                  "pending" => "Pendente",
                  "received" => "Recebido"
                }

  ENUM_KIND_DESCRIPTION = {
                            "refund" => "Reembolso de Despesas",
                            "addition" => "Adicional de Contrato",
                            "discount" => "Desconto Contratual",
                            "reversal" => "Estorno de Valores",
                            "error" => "Erro Operacional",
                          }

  ENUM_KIND = {
                "refund" => "Reembolso",
                "addition" => "Adicional",
                "discount" => "Desconto",
                "reversal" => "Estorno",
                "error" => "Erro Operacional",
              }

end