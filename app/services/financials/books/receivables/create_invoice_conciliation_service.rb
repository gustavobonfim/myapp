class Financials::Books::Receivables::CreateInvoiceConciliationService

  def initialize(invoice, receivable_ids, adjustment_ids)
    @invoice = invoice    
    @receivable_ids = receivable_ids
    @adjustment_ids = adjustment_ids
    @items = []
    @conciliation = []
  end

  def create_concilation
    set_receivables
    
  end

  def set_receivables
    @receivable_ids.each do |id|
      receivable = ::Financials::Books::Receivables::EntityRepository.find_by_id(id)
      receivable.status = @invoice.status

      conciliation_attrs = {
                              "invoice_id" => @invoice.id,
                              "receivable_id" => receivable.id,
                              "receivable_type" => receivable.class.name,
                              "receivable_kind" => "receivable",
                              "status" => @invoice.status,
                            }

      item_attrs = {
                      "invoice_id" => @invoice.id,
                      "description" => receivable.description,
                      "price_cents" => (receivable.amount * 100).to_i,
                      "quantity" => 1,
                      "kind" => receivable.kind,
                      "amount" => r.amount,
                    }

      conciliation = conciliation(conciliation_attrs)
      if conciliation.valid?
        @conciliations << conciliation
      end

      item = item(item_attrs)
      if item.valid?
        @items << item
      end
      
    end
  end

  def conciliation(attrs)
    ::Financials::Books::Receivables::ConciliationRepository.build(attrs)
  end

  def item(attrs)
    ::Financials::Books::Receivables::InvoiceItemRepository.build(attrs)
  end
  

  # Item = Struct.new(:invoice_id, :description, :price_cents, :quantity, :kind, :amount)
  # Conciliation = Struct.new(:invoice_id, :receivable_id, :receivable_type, :receivable_kind, :status)
  
  

end