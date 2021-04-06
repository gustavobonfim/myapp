class Financials::Books::Settings::ChartAccounts::CreateChartAccountService

  def initialize(attrs)
    @attrs = attrs

    # destroy_all_chart_accounts
    create_chart_account
  end

  def destroy_all_chart_accounts
    Financial::Book::Setting::ChartAccount.destroy_all
  end
  
  def create_chart_account
    ActiveRecord::Base.transaction do
      @attrs.each do |attrs|
        # if attrs["code"].to_i < 10
        #   attrs = attrs.merge({ "code" => "0#{attrs["code"]}" })      
        # end

        obj = chart_account(attrs)

        if obj.valid?
          obj.save
        else




          debugger



          raise ActiveRecord::Rollback
        end
      end
    end
  end
  
  def chart_account(attrs)
    ::Financials::Books::Settings::ChartAccountRepository.build(attrs)
  end
  
end