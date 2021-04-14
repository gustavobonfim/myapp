class Financials::Books::Balances::RefreshBalancesService

  def initialize(date)
    @date = date

    refresh_balances
  end
  
  def refresh_balances

    balances = ::Financials::Books::Balances::EntityRepository.all_active_by_date(@date.id)

    balances.each do |obj|
      obj.balance = 0
      obj.save
    end

    transactions = ::Financials::Books::Transactions::EntityRepository.all_active_by_date(@date.id)
    transactions.each do |obj|
      ::Financials::Books::Balances::UpdateBalancesService.new(obj)
    end

  end
  
end