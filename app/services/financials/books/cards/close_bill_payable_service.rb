class Financials::Books::Cards::CloseBillPayableServiceex

  def initialize(bill)
    @bill = bill

    create_bill_payable
  end
  
  def create_bill_payable
    set_from_and_to_chart_account
    set_from_and_to_amount
    set_date
    set_channel

    attrs = {
              "med_id" => @bill.card.med_id,
              "date_id" => @date.id,
              "channel_id" => @channel.id,
              "channel_name" => @channel.name,
              "provider_id" => @bill.card.provider_id,
              "provider_name" => @bill.card.provider.name,
              "due_date" => @bill.due_date,
              "accrual_date" => @bill.closing_date,
              "amount" => @bill.balance,
              "description" => "Pgt Ref #{@bill.name}",
              "chart_id" => @to.id,
              "chart_account" => @to.chart_account,
              "chart_name" => @to.chart_name,
              "chart_master_name" => @to.master_name,
              "chart_group" => @to.group,
              "method" => "bank_split",
              "kind" => @to.kind,
              "recurring" => true,
              "splited" => false,
              "split" => 1,
              "installment" => 1
            }

    obj = payable(attrs)

    if obj.valid?
      obj.save
      ::Financials::Books::Payables::CreatePayableTransactionService.new(obj)
    end
  end
  
  def payable(attrs)
    ::Financials::Books::Payables::EntityRepository.build(attrs)
  end

  def set_from_and_to_chart_account
    @to = ::Financials::Books::Settings::ChartAccountRepository.find_by_name(@bill.card.name)
    from_name = ::Financials::Books::Settings::ChartAccountRepository::ENUM_MASTER_NAME.select{|key,value| key == @to.master_name}.values.first
    @from = ::Financials::Books::Settings::ChartAccountRepository.find_by_name(from_name)
  end

  def set_from_and_to_amount
    if @from.master == "liability" || @from.master == "revenues"
      @from_amount = @bill.balance
    else
      @from_amount = - @bill.balance
    end

    if @to.master == "asset" || @to.master == "expenses"
      @to_amount = @bill.balance
    else
      @to_amount = - @bill.balance
    end  
  end

  def set_date
    @bill.closing_date = @bill.closing_date - 10.days
    @date = ::Financials::Config::FindOrCreateDateService.new(@bill.closing_date).find_or_create_date
  end

  def set_channel
    @channel = ::Financials::Books::Settings::ChannelRepository.find_by_name(@bill.card.channel_name)
  end
  
  
end