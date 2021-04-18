class Financials::Books::Statements::DestroyInternTransactionService

  def initialize(transaction)
    @transaction = transaction
    @transactions = transactions

    destroy_transaction
  end
  
  def destroy_transaction
    @transactions.each do |transaction|
      transaction.destroy
      ::Financials::Books::Balances::UpdateBalancesService.new(transaction)
    end
  end
  
  def transactions
    ::Financials::Books::Transactions::EntityRepository.all_active_by_token_tree(@transaction.token_tree)
  end

end