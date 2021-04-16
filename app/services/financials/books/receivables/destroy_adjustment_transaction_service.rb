class Financials::Books::Receivables::DestroyAdjustmentTransactionService

  def initialize(adjustment)
    @adjustment = adjustment
    @transactions = @transactions

  end
  
  def destroy_transaction
    transactions.each do |transaction|
      transaction.destroy
      ::Financials::Books::Balances::UpdateBalancesService.new(transaction)
    end
  end
  
  def transactions
    token = "a:#{@adjustment.token}"
    ::Financials::Books::Transactions::EntityRepository.all_active_by_token_tree(token)
  end
  
end