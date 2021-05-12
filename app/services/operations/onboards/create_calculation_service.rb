class Operations::Onboards::CreateCalculationService

  def initialize(date)
    
    @date = date

    create_calculation
    
  end

  def create_calculation
    
    @date.create_calculation! unless @date.calculation.present?

  end
  
end