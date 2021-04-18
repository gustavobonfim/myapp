class Financials::Books::Receivables::Entities::UpdatePaidTransactionService

  def initialize(invoice, receivable)
    @invoice = invoice
    @receivable = receivable

    update_receivable_transaction
  end
  
  def update_receivable_transaction
    set_from_and_to_chart_account
    set_from_and_to_amount

    attrs = {
              "date_id" => @receivable.date_id,
              "med_id" => @receivable.med_id,
              "channel_id" => @receivable.channel_id,
              "date" => @receivable.due_date,
              "description" => @receivable.description,
              "method" => @receivable.method,
              "channel_name" => @receivable.channel_name,
              "token_tree" => "r:#{@receivable.token}",
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
              "amount" => @invoice.total_amount,
              "from_amount" => @from_amount,
              "to_amount" => @to_amount,
              "kind" => @from.kind,
              "source" => "receivable",
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
    from_chart_name = "Clientes | #{::Financials::Books::Settings::ChartAccountRepository::ENUM_GROUP.select{|key,value| key == @receivable.chart.group}.values.first}"
    @from = ::Financials::Books::Settings::ChartAccountRepository.find_by_chart_name(from_chart_name)

    @to = @receivable.contract.channel.chart
  end

  def set_from_and_to_amount
    if @from.master == "liability" || @from.master == "revenues"
      @from_amount = @invoice.total_amount
    else
      @from_amount = - @invoice.total_amount
    end

    if @to.master == "asset" || @to.master == "expenses"
      @to_amount = @invoice.total_amount
    else
      @to_amount = - @invoice.total_amount
    end  
  end
  
end