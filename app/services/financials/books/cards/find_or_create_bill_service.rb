class Financials::Books::Cards::FindOrCreateBillService

  def initialize(card, pay_day, closing_day)
    @card = card
    @pay_day = pay_day
    @closing_day = closing_day
    @year = @pay_day.year
    @month = @pay_day.month
    @day = @pay_day.day
    @bill_token = set_bill_token
  end

  def find_or_create_bill
    bill = find_or_initialize_bill

    if bill.new_record?
      bill.card_id = @card.id
      bill.day = @day
      bill.month = @month
      bill.year = @year
      bill.invoice = "open"
      bill.due_date = @pay_day
      bill.closing_date = @closing_day

      bill.save
      # ::Financials::Products::Purchases::CreateCalculationService.new(bill)
    end
    
    return bill
  end
  
  def find_or_initialize_bill
    ::Financials::Books::Cards::BillRepository.find_or_initialize_by_token(@bill_token)
  end

  def set_bill_token
    card_code = @card.id.to_s.rjust(3,"0").upcase
    year_code = @year.to_s.rjust(4,"0").upcase
    month_code = @month.to_s.rjust(2,"0").upcase

    return "#{card_code}#{year_code}#{month_code}"
  end
  
end