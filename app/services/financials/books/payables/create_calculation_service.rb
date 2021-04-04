class Financials::Books::Payables::CreateCalculationService

  def initialize(date)
    
    @date = date

    create_calculation
    
  end

  def create_calculation
    
    @date.create_payable_calculation! unless @date.payable_calculation.present?

  end
  
end