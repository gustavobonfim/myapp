class Financials::Books::Payables::UpdateCalculationService
  
  def initialize(med, date)
    @med = med
    @date = date
    @calculation = calculation
    @payables = payables

    update_calculation
  end

  def payables
    ::Financials::Books::Payables::EntityRepository.all_active_by_date(@date.id)
  end

  def calculation
    Financials::Books::Payables::CalculationRepository.find_by_date_and_med(@date.id, @med.id)
  end

  def update_calculation

    # if CALCULATION_ATTR.include?(@field)
    #   @calculation[@field] = @payables.where(chart_group: @field).sum(:amount)
    # end

    # @calculation.operation_staff_expenses = @payables.where(chart_group: "operation_staff_expenses").sum(:amount)
    # @calculation.commercial_staff_expenses = @payables.where(chart_group: "commercial_staff_expenses").sum(:amount)
    # @calculation.administrative_staff_expenses = @payables.where(chart_group: "administrative_staff_expenses").sum(:amount)
    # @calculation.general_staff_expenses = @payables.where(chart_group: "general_staff_expenses").sum(:amount)
    # @calculation.sales_expenses = @payables.where(chart_group: "sales_expenses").sum(:amount)
    # @calculation.marketing_expenses = @payables.where(chart_group: "marketing_expenses").sum(:amount)
    # @calculation.technology_expenses = @payables.where(chart_group: "technology_expenses").sum(:amount)
    # @calculation.services_expenses = @payables.where(chart_group: "services_expenses").sum(:amount)
    # @calculation.administrative_expenses = @payables.where(chart_group: "administrative_expenses").sum(:amount)
    # @calculation.general_expenses = @payables.where(chart_group: "general_expenses").sum(:amount)
    # @calculation.grant_depreciation_expenses = @payables.where(chart_group: "grant_depreciation_expenses").sum(:amount)
    # @calculation.financial_expenses = @payables.where(chart_group: "financial_expenses").sum(:amount)
    # @calculation.grant_losses_realization = @payables.where(chart_group: "grant_losses_realization").sum(:amount)

    @calculation.technology_staff_expenses = @payables.select{|p| p.chart_group == "technology_staff_expenses"}.map{|p| p.amount}.sum
    @calculation.operation_staff_expenses = @payables.select{|p| p.chart_group == "operation_staff_expenses"}.map{|p| p.amount}.sum
    @calculation.commercial_staff_expenses = @payables.select{|p| p.chart_group == "commercial_staff_expenses"}.map{|p| p.amount}.sum
    @calculation.administrative_staff_expenses = @payables.select{|p| p.chart_group == "administrative_staff_expenses"}.map{|p| p.amount}.sum
    @calculation.general_staff_expenses = @payables.select{|p| p.chart_group == "general_staff_expenses"}.map{|p| p.amount}.sum
    @calculation.sales_expenses = @payables.select{|p| p.chart_group == "sales_expenses"}.map{|p| p.amount}.sum
    @calculation.marketing_expenses = @payables.select{|p| p.chart_group == "marketing_expenses"}.map{|p| p.amount}.sum
    @calculation.technology_expenses = @payables.select{|p| p.chart_group == "technology_expenses"}.map{|p| p.amount}.sum
    @calculation.services_expenses = @payables.select{|p| p.chart_group == "services_expenses"}.map{|p| p.amount}.sum
    @calculation.administrative_expenses = @payables.select{|p| p.chart_group == "administrative_expenses"}.map{|p| p.amount}.sum
    @calculation.general_expenses = @payables.select{|p| p.chart_group == "general_expenses"}.map{|p| p.amount}.sum
    @calculation.grant_depreciation_expenses = @payables.select{|p| p.chart_group == "grant_depreciation_expenses"}.map{|p| p.amount}.sum
    @calculation.financial_expenses = @payables.select{|p| p.chart_group == "financial_expenses"}.map{|p| p.amount}.sum
    @calculation.grant_losses_realization = @payables.select{|p| p.chart_group == "grant_losses_realization"}.map{|p| p.amount}.sum


    @calculation.total_staff_expenses = @calculation.technology_staff_expenses + @calculation.operation_staff_expenses + @calculation.commercial_staff_expenses + @calculation.administrative_staff_expenses + @calculation.general_staff_expenses
    @calculation.total_commercial_expenses = @calculation.commercial_staff_expenses + @calculation.sales_expenses + @calculation.marketing_expenses
    @calculation.total_technology_expenses = @calculation.technology_staff_expenses + @calculation.technology_expenses
    @calculation.total_operation_expenses = @calculation.operation_staff_expenses + @calculation.services_expenses + @calculation.grant_losses_realization
    @calculation.total_administrative_expenses = @calculation.administrative_staff_expenses + @calculation.general_staff_expenses + @calculation.administrative_expenses + @calculation.general_expenses + @calculation.grant_depreciation_expenses
    
    @calculation.save

  end


  CALCULATION_ATTR = ["people_expenses", "technology_expenses", "exempt_income", "definitive_income", "profit_income", "investment_income", "booking", "pension",
                      "health", "others", "paid_tax", "withheld_tax", "paid_social", "withheld_social", "cash_assets", "property_assets"]

end