class Financials::Books::Receivables::InvoiceRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    obj.status = "pending"
    obj.token = set_token("token").upcase
    
    return obj
  end

  def self.find_and_change(attrs)
    obj = entity.find_by(id: attrs["id"])
    obj.attributes = attrs
    
    return obj
  end

  def self.all_active
    # entity.where(active: true).includes(:items, contract: [:taker])
    entity.where(active: true).includes(:items, :taker)
  end

  def self.all_active_by_contract(contract_id)
    entity.where(active: true, contract_id: contract_id).includes(:items)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.read(invoice)
    mapper.map(invoice)
  end
  
  def self.list(invoices)
    mapper.map_all(invoices)
  end

  def self.has_not_pending_invoice(contract_id)
    all_invoices = entity.where(active: true, contract_id: contract_id)
    pending_invoices = all_invoices.select{|invoice| invoice.status == "pending"}

    if all_invoices.count == 0 || (all_invoices.count > 0 && pending_invoices.count == 0)
      return true
    else
      return false
    end
    
  end
  

  private

  def self.entity
    "Financial::Book::Receivable::Invoice".constantize
  end

  def self.mapper
    "Financials::Books::Receivables::InvoiceMapper".constantize
  end

  def self.set_token(field)
    token = Base.generate_token
    set_token if valid_field(field, token)
    token
  end

  ENUM_STATUS = {
                  "pending" => "Pendente",
                  "paid" => "Paga",
                  "canceled" => "Cancelada",
                  "expired" => "Expirada",
                  "refund" => "Reembolsada",
                }

  ENUM_METHOD = {
                  "bank_split" => "Boleto Bancário",
                  "credit_card" => "Cartão de Crédito",
                  "transfer" => "Transferência",
                  "pix" => "PIX",
                }

end