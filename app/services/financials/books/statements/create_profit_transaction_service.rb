class Financials::Books::Statements::CreateProfitTransactionService

  def initialize(transaction)
    @transaction = transaction

    create_profit_transaction
  end
  
  def create_profit_transaction
    set_from_and_to_chart_account
    set_from_and_to_amount

    attrs = {
              "date_id" => @transaction.date_id,
              "med_id" => @transaction.med_id,
              "date" => @transaction.date,
              "description" => "Resultado: #{@transaction.description}",
              "method" => @transaction.method,
              "channel_name" => @transaction.channel_name,
              "token_tree" => @transaction.token_tree,
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
              "amount" => @transaction.amount,
              "from_amount" => @from_amount,
              "to_amount" => @to_amount,
              "kind" => "balance",
              "intern" => true,
              "source" => @transaction.source,
            }

    obj = transaction(attrs)
    if obj.valid?
      obj.save
      ::Financials::Books::Balances::UpdateBalancesService.new(obj)
    end
  end
  
  def transaction(attrs)
    ::Financials::Books::Transactions::EntityRepository.build(attrs)
  end

  def set_from_and_to_chart_account
    from_name = "Resultado"
    to_name = "Lucro/Prejuízo Acumulado"
    
    @from = ::Financials::Books::Settings::ChartAccountRepository.find_by_name(from_name)
    @to = ::Financials::Books::Settings::ChartAccountRepository.find_by_name(to_name)
  end

  def set_from_and_to_amount
    if @transaction.from.master == "revenues" || @transaction.from.master == "expenses" || @transaction.from.master == "taxes"
      @from_amount = @transaction.amount
    else
      @from_amount = - @transaction.amount
    end

    if @transaction.to.master == "revenues" || @transaction.to.master == "expenses" || @transaction.to.master == "taxes"
      @to_amount = - @transaction.amount
    else
      @to_amount = @transaction.amount
    end  
  end
  
end