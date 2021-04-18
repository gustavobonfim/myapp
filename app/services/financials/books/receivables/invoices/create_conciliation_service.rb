class Financials::Books::Receivables::Invoices::CreateConciliationService

  def initialize(invoice, receivable_ids, adjustment_ids)
    @invoice = invoice    
    @receivable_ids = receivable_ids
    @adjustment_ids = adjustment_ids
    @items = []
    @conciliations = []

    set_receivables
    set_adjustments
  end

  def create_concilation

    @items.each do |item|
      item.save
    end

    @conciliations.each do |conciliation|
      conciliation.save
    end

    ::Financials::Books::Receivables::Invoices::UpdateService.new(@invoice)
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
                      "amount" => receivable.amount,
                    }

      conciliation = conciliation(conciliation_attrs)
      if conciliation.valid?
        @conciliations << conciliation if receivable.contract_id == @invoice.contract_id
      end

      item = item(item_attrs)
      if item.valid?
        @items << item if receivable.contract_id == @invoice.contract_id
      end
      
    end
  end

  def set_adjustments
    @adjustment_ids.each do |id|
      adjustment = ::Financials::Books::Receivables::AdjustmentRepository.find_by_id(id)
      adjustment.status = @invoice.status

      conciliation_attrs = {
                              "invoice_id" => @invoice.id,
                              "receivable_id" => adjustment.id,
                              "receivable_type" => adjustment.class.name,
                              "receivable_kind" => "adjustment",
                              "status" => @invoice.status,
                            }

      item_attrs = {
                      "invoice_id" => @invoice.id,
                      "description" => adjustment.description,
                      "price_cents" => (adjustment.amount * 100).to_i,
                      "quantity" => 1,
                      "kind" => adjustment.kind,
                      "amount" => adjustment.amount,
                    }

      conciliation = conciliation(conciliation_attrs)
      if conciliation.valid?
        @conciliations << conciliation  if adjustment.contract_id == @invoice.contract_id
      end

      item = item(item_attrs)
      if item.valid?
        @items << item  if adjustment.contract_id == @invoice.contract_id
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