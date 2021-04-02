class Financials::Balances::Statements::ChartAccounts::CreateChartAccountService

  def initialize(attrs)
    @attrs = attrs

    destroy_all_chart_accounts
    create_chart_account
  end

  def destroy_all_chart_accounts
    Financial::Balance::Statement::ChartAccount.destroy_all
  end
  

  def create_chart_account
    @attrs.each do |attrs|
      if attrs["code"].to_i < 10
        attrs = attrs.merge({ "code" => "0#{attrs["code"]}" })      
      end

      obj = chart_account(attrs)
      obj.save
    end
  end
  
  def chart_account(attrs)
    ::Financials::Balances::Statements::ChartAccountRepository.build(attrs)
  end
  
end