class Financials::Books::Receivables::Invoices::UpdateDestroyService

  def initialize(invoice)
    @invoice = invoice
    @conciliations = conciliations
    
    update_destroy_invoice
  end

  def conciliations
    ::Financials::Books::Receivables::ConciliationRepository.all_active_by_invoice(@invoice.id)
  end

  def update_destroy_invoice

    @conciliations.each do |conciliation|

      receivable = conciliation.receivable_type.constantize.find(conciliation.receivable_id)
      receivable.received = false
      receivable.status = "pending"
      receivable.save

    end

  end

end