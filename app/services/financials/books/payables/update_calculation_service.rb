class Financials::Books::Payables::UpdateCalculationService
  
  def initialize(date)
    @date = date
    @payables = payables

    update_calculation
  end

  def payables
    ::Financials::Books::Payables::EntityRepository.all_active_by_date(@date.id)
  end

  def calculation
    Financials::Books::Payables::CalculationRepository.find_by_date(@date.id)
  end

  def update_calculation

    # if CALCULATION_ATTR.include?(@field)
    #   @calculation[@field] = @payables.where(chart_group: @field).sum(:amount)
    # end

    @calculation.people_expenses = @payables.where(chart_group: "people_expenses").sum(:amount)
    @calculation.technology_expenses = @payables.where(chart_group: "technology_expenses").sum(:amount)
    
    @calculation.save

  end


  CALCULATION_ATTR = ["people_expenses", "technology_expenses", "exempt_income", "definitive_income", "profit_income", "investment_income", "booking", "pension",
                      "health", "others", "paid_tax", "withheld_tax", "paid_social", "withheld_social", "cash_assets", "property_assets"]

end