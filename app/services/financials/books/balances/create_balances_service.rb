class Financials::Books::Balances::CreateBalancesService

  def initialize(date)
    @date = date
    @meds = meds
    @chart_accounts = chart_accounts

    create_balances
  end
  
  def create_balances

    @meds.each do |med|
      @chart_accounts.each do |chart_account|
        previous_obj = previous_balance(med.id, chart_account.id)

        attrs = {
                  "date_id" => @date.id,
                  "med_id" => med.id,
                  "chart_id" => chart_account.id,
                  "kind" => chart_account.kind,
                  "balance" => 0,
                  "previous_balance" => previous_obj.balance,
                  "chart_name" => chart_account.chart_name,
                  "chart_code" => chart_account.token,
                }

        obj = balance(attrs)
        if obj.valid?
          obj.save
        end
      end
    end

  end

  def previous_balance(med_id, chart_id)
    ::Financials::Books::Balances::EntityRepository.find_previous_balance(med_id, chart_id)
  end

  def balance(attrs)
    ::Financials::Books::Balances::EntityRepository.build(attrs)
  end
  
  def chart_accounts
    ::Financials::Books::Settings::ChartAccountRepository.all_active
  end

  def meds
    ::Users::Companies::EntityRepository.all_active_by_kind("med")
  end
  
end