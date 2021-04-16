class Financials::Books::Receivables::PrepareReceivableService
  
  def initialize(attrs)
    @attrs = attrs
    @contract = contract
    @date = date
  end

  def prepare_receivable
    set_chart_account
    date_short_name = DateDecorator.abbr_with_month_year(@date.month, @date.year)
    kind_pretty = Financials::Books::Receivables::EntityRepository::ENUM_KIND[@attrs[:kind]]

    attrs = {
              "date_id" => @date.id,
              "chart_id" => @chart.id,
              "med_id" => @contract.med_id,
              "channel_id" => @contract.channel_id,
              "contract_id" => @contract.id,
              "contract_token" => @contract.token,
              "due_date" => @attrs[:due_date],
              "amount" => @attrs[:amount],
              "description" => "#{kind_pretty} | #{@contract.name} | #{date_short_name}",
              "chart_account" => @chart.chart_account,
              "chart_name" => @chart.chart_name,
              "chart_master_name" => @chart.master_name,
              "chart_group" => @chart.group,
              "kind" => @attrs[:kind],
              "method" => @contract.method,
              "channel_name" => @contract.channel_name
            }

    obj = receivable(attrs)
    # if obj.valid?
    #   obj.save
    #   ::Financials::Books::Contracts::UpdateCalculationService.new(@contract, @date)
    #   ::Financials::Books::Receivables::UpdateCalculationService.new(@contract.med, @date)
    #   ::Financials::Books::Receivables::CreateReceivableTransactionService.new(obj)
    # end

    return obj
  end
  
  def receivable(attrs)
    ::Financials::Books::Receivables::EntityRepository.build(attrs)
  end

  def set_chart_account




    

    name = ::Financials::Books::Receivables::GetReversalChartName::TRANSLATE[@contract.product_name]
    from_chart_name = "Clientes | #{::Financials::Books::Settings::ChartAccountRepository::ENUM_GROUP.select{|key,value| key == name}.values.first}"
    to_chart_name = "Recebimentos Antecipados | #{::Financials::Books::Settings::ChartAccountRepository::ENUM_GROUP.select{|key,value| key == name}.values.first}"
    @from = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(from_chart_name)
    @to = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(to_chart_name)




    debugger





    @chart = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(chart_name)
  end

  def contract
    ::Financials::Books::Contracts::EntityRepository.find_by_id(@attrs[:contract_id])
  end

  def date
    ::Financials::Config::DateRepository.find_by_id(@attrs[:date_id])
  end

end