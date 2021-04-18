class Financials::Books::Receivables::Invoices::UpdateService
  
  def initialize(invoice)
    @invoice = invoice
    @items = items
    
    update_invoice
  end

  def items
    ::Financials::Books::Receivables::InvoiceItemRepository.all_active_by_invoice(@invoice.id)
  end

  def update_invoice
    
    @invoice.total_income_amount = @items.select{|i| i.kind == "income"}.map{|i| i.amount}.sum
    @invoice.total_refund_amount = @items.select{|i| i.kind == "refund"}.map{|i| i.amount}.sum
    @invoice.total_discount_amount = @items.select{|i| i.kind == "discount"}.map{|i| i.amount}.sum
    @invoice.total_reversal_amount = @items.select{|i| i.kind == "reversal"}.map{|i| i.amount}.sum
    @invoice.total_error_amount = @items.select{|i| i.kind == "error"}.map{|i| i.amount}.sum

    @invoice.total_invoice_amount = @invoice.total_income_amount - @invoice.total_discount_amount
    @invoice.total_amount = @invoice.total_income_amount + @invoice.total_refund_amount - @invoice.total_discount_amount - @invoice.total_reversal_amount - @invoice.total_error_amount
    @invoice.total_amount_cents = (@invoice.total_amount * 100).to_i

    @invoice.save
  end

end