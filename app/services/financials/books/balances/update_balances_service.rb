class Financials::Books::Balances::UpdateBalancesService

  def initialize(obj)
    @obj = obj

    update_from_balance
    update_to_balance
  end
  
  def update_from_balance

    from_balance = balance(from_id)
    from_transaction = transactions

    obj = transaction(attrs)
    if obj.valid?
      obj.save
      ::Financials::Books::Balances::UpdateBalanceService.new(obj)
    end
  end
  
  def balance(chart_id)
    ::Financials::Books::Balances::EntityRepository.find_by_date_and_med(@obj.date_id, @obj.med_id, chart_id)
  end
  
end