class Financials::Books::Receivables::UpdateCalculationService
  
  def initialize(med, date)
    @med = med
    @date = date
    @calculation = calculation
    @receivables = receivables

    update_calculation
  end

  def receivables
    ::Financials::Books::Receivables::EntityRepository.all_active_by_date(@date.id)
  end

  def calculation
    Financials::Books::Receivables::CalculationRepository.find_by_date_and_med(@date.id, @med.id)
  end

  def update_calculation

    @calculation.accounting = @receivables.select{|p| p.chart_group == "accounting"}.map{|p| p.amount}.sum
    @calculation.biling = @receivables.select{|p| p.chart_group == "biling"}.map{|p| p.amount}.sum
    @calculation.investment = @receivables.select{|p| p.chart_group == "investment"}.map{|p| p.amount}.sum
    @calculation.protection = @receivables.select{|p| p.chart_group == "protection"}.map{|p| p.amount}.sum
    @calculation.miscellaneous = @receivables.select{|p| p.chart_group == "miscellaneous"}.map{|p| p.amount}.sum
    @calculation.financial_revenues = @receivables.select{|p| p.chart_group == "financial_revenues"}.map{|p| p.amount}.sum
    @calculation.medclinic = @receivables.select{|p| p.chart_master_name == "medclinic"}.map{|p| p.amount}.sum
    @calculation.medbooking = @receivables.select{|p| p.chart_master_name == "medbooking"}.map{|p| p.amount}.sum
    @calculation.medfiling = @receivables.select{|p| p.chart_master_name == "medfiling"}.map{|p| p.amount}.sum
    @calculation.medpayroll = @receivables.select{|p| p.chart_master_name == "medpayroll"}.map{|p| p.amount}.sum
    @calculation.medreceivement = @receivables.select{|p| p.chart_master_name == "medreceivement"}.map{|p| p.amount}.sum
    @calculation.medbiling = @receivables.select{|p| p.chart_master_name == "medbiling"}.map{|p| p.amount}.sum
    @calculation.medinvestment = @receivables.select{|p| p.chart_master_name == "medinvestment"}.map{|p| p.amount}.sum
    @calculation.medprotection = @receivables.select{|p| p.chart_master_name == "medprotection"}.map{|p| p.amount}.sum
    @calculation.medconsulting = @receivables.select{|p| p.chart_master_name == "medconsulting"}.map{|p| p.amount}.sum
    @calculation.interests_revenues = @receivables.select{|p| p.chart_master_name == "interests_revenues"}.map{|p| p.amount}.sum
    @calculation.exchange_variation_revenues = @receivables.select{|p| p.chart_master_name == "exchange_variation_revenues"}.map{|p| p.amount}.sum
    @calculation.miscellaneous_revenues = @receivables.select{|p| p.chart_master_name == "miscellaneous_revenues"}.map{|p| p.amount}.sum
    
    @calculation.total_income_amount = @receivables.select{|p| p.kind == "income"}.map{|p| p.amount}.sum
    @calculation.total_refund_amount = @receivables.select{|p| p.kind == "refund"}.map{|p| p.amount}.sum
    @calculation.total_discount_amount = @receivables.select{|p| p.kind == "discount"}.map{|p| p.amount}.sum
    @calculation.total_amount = @calculation.total_income_amount + @calculation.total_refund_amount - @calculation.total_discount_amount

    @calculation.total_income_received_amount = @receivables.select{|p| p.received && p.kind == "income"}.map{|p| p.amount}.sum
    @calculation.total_refund_received_amount = @receivables.select{|p| p.received && p.kind == "refund"}.map{|p| p.amount}.sum
    @calculation.total_received_amount = @calculation.total_income_received_amount + @calculation.total_refund_received_amount

    @calculation.save

  end

end