class Financials::Books::Receivables::CreateAdjustmentTransactionService

  def initialize(adjustment)
    @adjustment = adjustment
    @contract = @adjustment.contract
    @date = @adjustment.financial_date

  end
  
  def create_transaction
    set_from_and_to_chart_account
    set_from_and_to_amount

    attrs = {
              "date_id" => @adjustment.date_id,
              "med_id" => @adjustment.med_id,
              "channel_id" => @contract.channel_id,
              "date" => @adjustment.due_date,
              "description" => "#{@adjustment.description} | #{@contract.name}",
              "method" => @contract.method,
              "channel_name" => @contract.channel_name,
              "token_tree" => "a:#{@adjustment.token}",
              "from_id" => @from.id,
              "from_master_name" => @from.master_name,
              "from_group" => @from.group,
              "from_master_group" => @from.master_group,
              "from_master" => @from.master,
              "to_id" => @to.id,
              "to_master_name" => @to.master_name,
              "to_group" => @to.group,
              "to_master_group" => @to.master_group,
              "to_master" => @to.master,
              "amount" => @adjustment.amount,
              "from_amount" => @from_amount,
              "to_amount" => @to_amount,
              "kind" => @from.kind,
            }

    obj = transaction(attrs)
    if obj.valid?
      obj.save
      ::Financials::Books::Balances::UpdateBalancesService.new(obj)
      ::Financials::Books::Statements::CreateProfitTransactionService.new(obj) if @adjustment.kind == "error" || @adjustment.kind == "discount"
    end
  end
  
  def transaction(attrs)
    ::Financials::Books::Transactions::EntityRepository.build(attrs)
  end

  def set_from_and_to_chart_account
    
    if @adjustment.kind == "refund"
      from_chart_name = "Créditos Diversos | Clientes"
      @from = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(from_chart_name)

      name = ::Financials::Books::Receivables::GetReversalChartName::TRANSLATE[@contract.product_name]
      to_chart_name = "Clientes | #{::Financials::Books::Settings::ChartAccountRepository::ENUM_GROUP.select{|key,value| key == name}.values.first}"
      @to = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(to_chart_name)
    elsif @adjustment.kind == "discount"
      name = ::Financials::Books::Receivables::GetReversalChartName::TRANSLATE[@contract.product_name]
      from_chart_name = "Clientes | #{::Financials::Books::Settings::ChartAccountRepository::ENUM_GROUP.select{|key,value| key == name}.values.first}"
      @from = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(from_chart_name)

      to_chart_name = ::Financials::Books::Receivables::GetIncomeChartName::TRANSLATE[@contract.product_name][@contract.kind][@contract.product_kind]
      @to = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(to_chart_name) 
    elsif @adjustment.kind == "reversal"
      name = ::Financials::Books::Receivables::GetReversalChartName::TRANSLATE[@contract.product_name]
      from_chart_name = "Clientes | #{::Financials::Books::Settings::ChartAccountRepository::ENUM_GROUP.select{|key,value| key == name}.values.first}"
      @from = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(from_chart_name)

      to_chart_name = "Estornos a Fazer | Clientes"
      @to = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(to_chart_name)
    elsif @adjustment.kind == "error"
      name = ::Financials::Books::Receivables::GetReversalChartName::TRANSLATE[@contract.product_name]
      from_chart_name = "Clientes | #{::Financials::Books::Settings::ChartAccountRepository::ENUM_GROUP.select{|key,value| key == name}.values.first}"
      @from = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(from_chart_name)

      to_chart_name = ::Financials::Books::Receivables::GetErrorChartName::TRANSLATE[@contract.product_name]
      @to = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(to_chart_name)
    end
    
  end

  def set_from_and_to_amount
    if @from.master == "liability" || @from.master == "revenues"
      @from_amount = @adjustment.amount
    else
      @from_amount = - @adjustment.amount
    end

    if @to.master == "asset" || @to.master == "expenses"
      @to_amount = @adjustment.amount
    else
      @to_amount = - @adjustment.amount
    end  
  end
  
end