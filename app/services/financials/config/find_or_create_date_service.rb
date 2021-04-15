class Financials::Config::FindOrCreateDateService

  def initialize(date_string)
    parse_date = Date.parse(date_string.to_s)
    @month = parse_date.month
    @year = parse_date.year
  end

  def find_or_create_date
    financial_date = find_or_initialize_date

    if financial_date.new_record?
      financial_date.save
      # ::Financials::Products::Purchases::CreateCalculationService.new(financial_date)
      ::Financials::Books::Balances::CreateBalancesService.new(financial_date)
      ::Financials::Books::Payables::CreateCalculationService.new(financial_date, nil)
      ::Financials::Books::Contracts::CreateCalculationService.new(financial_date, nil)
      ::Financials::Books::Receivables::CreateCalculationService.new(financial_date, nil)
    end
    
    return financial_date
  end
  
  def find_or_initialize_date
    ::Financials::Config::DateRepository.find_or_initialize(@month, @year)
  end
  
end