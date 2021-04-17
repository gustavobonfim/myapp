class Financials::Books::Receivables::CreateInvoiceConciliationService

  def initialize(invoice, receivable_ids, adjustment_ids)
    @invoice = invoice    
    @receivable_ids = receivable_ids
    @adjustment_ids = adjustment_ids
    @items = []
  end

  def create_concilation
    
  end

  Item = Struct.new
  Conciliation = Struct.new
  
  

end