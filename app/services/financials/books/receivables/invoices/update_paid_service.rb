class Financials::Books::Receivables::Invoices::UpdatePaidService

  def initialize(invoice)
    @invoice = invoice
    @conciliations = conciliations
    
    update_paid_invoice
  end

  def conciliations
    ::Financials::Books::Receivables::ConciliationRepository.all_active_by_invoice(@invoice.id)
  end

  def update_paid_invoice

    @conciliations.each do |conciliation|

      conciliation.status = @invoice.status
      conciliation.save

      receivable = conciliation.receivable_type.constantize.find(conciliation.receivable_id)
      receivable.received = true
      receivable.status = "received"
      receivable.save

      income_receivable = receivable if conciliation.receivable_kind == "receivable"
    end
    
    ::Financials::Books::Receivables::Entities::UpdatePaidTransactionService.new(@invoice, income_receivable) if income_receivable
    ::Financials::Books::Receivables::Calculations::UpdateService.new(income_receivable.med, income_receivable.financial_date) if income_receivable

  end

end