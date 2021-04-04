class Financials::Books::Balances::UpdateBalancesService

  def initialize(obj)
    @obj = obj

    update_from_balance
    update_to_balance
  end
  
  def update_from_balance

    from_balance = balance(@obj.from_id)
    @from_transactions = from_transactions

    if from_balance.kind == "balance"
      from_balance.balance = from_balance.previous_balance + @from_transactions.sum(:from_amount) + @from_transactions.sum(:to_amount)
    else
      from_balance.balance = @from_transactions.sum(:from_amount) + @from_transactions.sum(:to_amount)
    end

    from_balance.save
  end

  def update_to_balance

    to_balance = balance(@obj.to_id)
    @to_transactions = to_transactions

    if to_balance.kind == "balance"
      to_balance.balance = to_balance.previous_balance + @to_transactions.sum(:from_amount) + @to_transactions.sum(:to_amount)
    else
      to_balance.balance = @to_transactions.sum(:from_amount) + @to_transactions.sum(:to_amount)
    end

    to_balance.save
  end
  
  def balance(chart_id)
    ::Financials::Books::Balances::EntityRepository.find_by_date_and_med(@obj.date_id, @obj.med_id, chart_id)
  end

  def from_transactions
    ::Financials::Books::Transactions::EntityRepository.all_active_by_date_and_from(@obj.date_id, @obj.from_id)
  end

  def to_transactions
    ::Financials::Books::Transactions::EntityRepository.all_active_by_date_and_to(@obj.date_id, @obj.to_id)
  end
  
end