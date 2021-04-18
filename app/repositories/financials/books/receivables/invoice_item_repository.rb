class Financials::Books::Receivables::InvoiceItemRepository < Base

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

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.read(invoice_item)
    mapper.map(invoice_item)
  end
  
  def self.list(invoice_items)
    mapper.map_all(invoice_items)
  end  

  private

  def self.entity
    "Financial::Book::Receivable::InvoiceItem".constantize
  end

  def self.mapper
    "Financials::Books::Receivables::InvoiceItemMapper".constantize
  end

  ENUM_KIND = {
                "income" => "Mensalidade",
                "refund" => "Reembolso",
                "addition" => "Adicional",
                "discount" => "Desconto",
                "reversal" => "Estorno",
                "error" => "Erro Operacional",
              }

end