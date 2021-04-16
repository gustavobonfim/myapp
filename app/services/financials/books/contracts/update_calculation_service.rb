class Financials::Books::Contracts::UpdateCalculationService
  
  def initialize(contract, date)
    @contract = contract
    @date = date
    @calculation = calculation
    @receivables = receivables
    @adjustments = adjustments

    update_calculation
  end

  def receivables
    ::Financials::Books::Receivables::EntityRepository.all_active_by_date_and_contract(@date.id, @contract.id)
  end

  def adjustments
    ::Financials::Books::Receivables::AdjustmentRepository.all_active_by_date_and_contract(@date.id, @contract.id)
  end

  def calculation
    ::Financials::Books::Contracts::CalculationRepository.find_by_date_and_taker(@date.id, @contract.taker_id)
  end

  def update_calculation
    @calculation.total_income_amount = @receivables.select{|r| r.kind == "income"}.map{|p| p.amount}.sum
    @calculation.total_refund_amount = @receivables.select{|r| r.kind == "refund"}.map{|p| p.amount}.sum

    @calculation.total_discount_amount = @adjustments.select{|r| r.kind == "discount"}.map{|p| p.amount}.sum
    @calculation.total_reversal_amount = @adjustments.select{|r| r.kind == "reversal"}.map{|p| p.amount}.sum
    @calculation.total_error_amount = @adjustments.select{|r| r.kind == "error"}.map{|p| p.amount}.sum

    @calculation.total_invoice_amount = @calculation.total_income_amount - @calculation.total_discount_amount - @calculation.total_reversal_amount - @calculation.total_error_amount
    @calculation.final_amount = @calculation.total_income_amount + @calculation.total_refund_amount - @calculation.total_discount_amount - @calculation.total_reversal_amount - @calculation.total_error_amount
    
    @calculation.save
  end

end