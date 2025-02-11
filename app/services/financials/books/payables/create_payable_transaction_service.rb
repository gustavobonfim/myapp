class Financials::Books::Payables::CreatePayableTransactionService

  def initialize(payable)
    @payable = payable

    create_payable_transaction
  end
  
  def create_payable_transaction
    set_from_and_to_chart_account
    set_from_and_to_amount

    attrs = {
              "date_id" => @payable.date_id,
              "med_id" => @payable.med_id,
              "channel_id" => @payable.channel_id,
              "date" => @payable.accrual_date,
              "description" => @payable.description,
              "method" => @payable.method,
              "channel_name" => @payable.channel_name,
              "token_tree" => "p:#{@payable.token}",
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
              "amount" => @payable.amount,
              "from_amount" => @from_amount,
              "to_amount" => @to_amount,
              "kind" => @to.kind,
              "source" => "payable",
            }

    obj = transaction(attrs)
    if obj.valid?
      obj.save
      ::Financials::Books::Payables::UpdateCalculationService.new(@payable.med, @payable.date)
      ::Financials::Books::Balances::UpdateBalancesService.new(obj)
      ::Financials::Books::Statements::CreateProfitTransactionService.new(obj) if @payable.kind == "statement"
    end
  end
  
  def transaction(attrs)
    ::Financials::Books::Transactions::EntityRepository.build(attrs)
  end

  def set_from_and_to_chart_account
    @to = @payable.chart
    from_name = ::Financials::Books::Settings::ChartAccountRepository::ENUM_MASTER_NAME.select{|key,value| key == @to.master_name}.values.first
    @from = ::Financials::Books::Settings::ChartAccountRepository.find_by_name(from_name)
  end

  def set_from_and_to_amount
    if @from.master == "liability" || @from.master == "revenues"
      @from_amount = @payable.amount
    else
      @from_amount = - @payable.amount
    end

    if @to.master == "asset" || @to.master == "expenses"
      @to_amount = @payable.amount
    else
      @to_amount = - @payable.amount
    end  
  end
  
end