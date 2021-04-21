class Financials::Books::Receivables::ConciliationRepository < Base

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

  def self.all_active_by_invoice(invoice_id)
    entity.where(active: true, invoice_id: invoice_id)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_receivable(receivable_id)
    entity.find_by(receivable_id: receivable_id)
  end

  def self.read(conciliation)
    mapper.map(conciliation)
  end
  
  def self.list(conciliations)
    mapper.map_all(conciliations)
  end  

  private

  def self.entity
    "Financial::Book::Receivable::Conciliation".constantize
  end

  def self.mapper
    "Financials::Books::Receivables::ConciliationMapper".constantize
  end

  ENUM_STATUS = {
                  "pending" => "Pendente",
                  "paid" => "Paga",
                  "canceled" => "Cancelada",
                  "expired" => "Expirada",
                  "refund" => "Reembolsada",
                }

  ENUM_RECEIVABLE_KIND = {
                            "receivable" => "Recebível",
                            "adjustment" => "Ajuste",
                          }

end