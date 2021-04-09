class Financials::Books::Cards::CreateCardTransactionService

  def initialize(payable)
    @payable = payable
    @channel = @payable.channel
    @card = @channel.card

    create_card_transaction
  end
  
  def create_card_transaction
    range = 1..@payable.installment
    first_pay = calculate_first_pay(@card, @payable.due_date)
    last_pay = calculate_last_pay(first_pay, @payable.installment)
    closing_day = calculate_closing_day(@card, @payable.due_date)

    range.each do |range|
      pay_day = first_pay + (range - 1).month
      closing_day = closing_day + (range - 1).month
      bill = set_bill(@card, pay_day, closing_day)

      attrs = {
                "card_id" => @card.id,
                "bill_id" => bill.id,
                "provider_id" => @payable.provider_id,
                "installment" => range,
                "quota" => "Parcela #{range} de #{@payable.installment}",
                "date" => @payable.due_date,
                "first_pay" => first_pay,
                "last_pay" => last_pay,
                "pay_day" => pay_day,
                "closing_day" => closing_day,
                "amount" => @payable.amount/@payable.installment,
                "description" => @payable.description,
                "chart_name" => @payable.chart_name,
                "token_tree" => @payable.token
              }

      obj = transaction(attrs)
      if obj.valid?
        obj.save
        ::Financials::Books::Cards::UpdateBillService.new(bill)
        # ::Financials::Books::Balances::UpdateBalancesService.new(obj)
        # ::Financials::Books::Statements::CreateProfitTransactionService.new(obj)
      end

    end

  end
  
  def transaction(attrs)
    ::Financials::Books::Cards::TransactionRepository.build(attrs)
  end

  def calculate_first_pay(card, date)
    if date.day < card.closing_day
      first_pay = Date.new(date.year, date.month, card.pay_day)
    else
      first_pay = Date.new(date.next_month.year, date.next_month.month, card.pay_day)
    end

    return first_pay
  end

  def calculate_closing_day(card, date)
    if date.day < card.closing_day
      closing_day = Date.new(date.year, date.month, card.closing_day)
    else
      closing_day = Date.new(date.next_month.year, date.next_month.month, card.closing_day)
    end

    return closing_day
  end

  def calculate_last_pay(first_pay, installment)
    return first_pay + (installment - 1).month
  end
  
  def set_bill(card, pay_day, closing_day)
    ::Financials::Books::Cards::FindOrCreateBillService.new(card, pay_day, closing_day).find_or_create_bill
  end
  
  
end