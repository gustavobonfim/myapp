class Commercial::Config::FindOrCreateDateService

  def initialize(date_string)
    parse_date = Date.parse(date_string.to_s)
    @month = parse_date.month
    @year = parse_date.year
  end

  def find_or_create_date
    commercial_date = find_or_initialize_date

    if commercial_date.new_record?
      commercial_date.save
      ::Commercial::Config::CreateCalculationService.new(commercial_date)
    end
    
    return commercial_date
  end
  
  
  def find_or_initialize_date
    ::Commercial::Config::DateRepository.find_or_initialize(@month, @year)
  end
  

  
end