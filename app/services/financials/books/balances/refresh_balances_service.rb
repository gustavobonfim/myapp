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

  end
  
end