class Operations::Onboards::FindOrCreateDateService

  def initialize(date_string)
    parse_date = Date.parse(date_string.to_s)
    @month = parse_date.month
    @year = parse_date.year
  end

  def find_or_create_date
    onboard_date = find_or_initialize_date

    if onboard_date.new_record?
      # onboard_date.save
      # ::Operation::Onboard::CreateCalculationService.new(onboard_date)
    end
    
    return onboard_date
  end
  
  
  def find_or_initialize_date
    ::Operations::Onboards::DateRepository.find_or_initialize(@month, @year)
  end
  

  
end