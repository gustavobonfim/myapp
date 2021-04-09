class Financials::Books::Cards::UpdateBillService
  
  def initialize(bill)
    @bill = bill
    @transactions = set_transactions

    update_calculation
  end

  def set_transactions
    ::Financials::Books::Cards::TransactionRepository.all_active_by_bill(@bill.id)
  end

  def update_calculation
    @bill.balance = @transactions.map{|p| p.amount}.sum
    
    @bill.save
  end

end