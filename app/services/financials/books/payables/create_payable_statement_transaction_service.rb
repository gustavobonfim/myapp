class Financials::Books::Payables::CreatePayableStatementTransactionService

  def initialize(payable)
    @payable = payable

    create_payable_transaction
  end
  
  def create_payable_transaction
    set_from_and_to_chart_account
    set_from_and_to_amount

    attrs = {
              "date_id" => @payable.date_id
              "med_id" => @payable.med_id
              "channel_id" => @payable.channel_id
              "from_id" => @payable.from_id
              "to_id" => @payable.to_id
              "date" => @payable.date
              "description" => @payable.description
              "method" => @payable.method
              "channel_name" => @payable.channel_name
              "token_tree" => @payable.token
              "from_master_name" => @from.master_name
              "from_group" => @from.group
              "from_master_group" => @from.master_group
              "from_master" => @from.master
              "to_master_name" => @to.master_name
              "to_group" => @to.group
              "to_master_group" => @to.master_group
              "to_master" => @to.master
              "amount" => @payable.amount
              "from_amount" => @from_amount
              "to_amount" => @to_amount
            }


    @attrs.each do |attrs|
      if attrs["code"].to_i < 10
        attrs = attrs.merge({ "code" => "0#{attrs["code"]}" })      
      end

      obj = chart_account(attrs)
      obj.save
    end
  end
  
  def transaction
    ::Financials::Books::Statements::TransactionRepository.build(attrs)
  end

  def set_from_and_to_chart_account
    @to = @payable.chart
    from_name = ::Financials::Books::Settings::ChartAccountRepository::ENUM_MASTER_NAME[@to.master_name]
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

  Transaction = Struct.new()
  
end