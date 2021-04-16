class Financials::Books::Contracts::CreateContractReceivableService

  def initialize(contract, date)
    @contract = contract
    @date = date

    # create_contract_receivable
  end
  
  def create_contract_receivable
    set_chart_account
    date_short_name = DateDecorator.abbr_with_month_year(@date.month, @date.year)

    attrs = {
              "date_id" => @date.id,
              "chart_id" => @chart.id,
              "med_id" => @contract.med_id,
              "channel_id" => @contract.channel_id,
              "contract_id" => @contract.id,
              "contract_token" => @contract.token,
              "due_date" => Date.new(@date.year, @date.month, @contract.due_day),
              "amount" => @contract.amount,
              "description" => "Mensalidade | #{@contract.name} | #{date_short_name}",
              "chart_account" => @chart.chart_account,
              "chart_name" => @chart.chart_name,
              "chart_master_name" => @chart.master_name,
              "chart_group" => @chart.group,
              "kind" => "income",
              "method" => @contract.method,
              "channel_name" => @contract.channel_name
            }

    obj = receivable(attrs)
    if obj.valid?
      obj.save
      ::Financials::Books::Contracts::UpdateCalculationService.new(@contract, @date)
      ::Financials::Books::Receivables::UpdateCalculationService.new(@contract.med, @date)
      ::Financials::Books::Receivables::CreateReceivableTransactionService.new(obj)
    end

    return obj
  end
  
  def receivable(attrs)
    ::Financials::Books::Receivables::EntityRepository.build(attrs)
  end

  def set_chart_account
    chart_name = ::Financials::Books::Receivables::GetIncomeChartName::TRANSLATE[@contract.product_name][@contract.kind][@contract.product_kind]
    @chart = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(chart_name)
  end
  
end