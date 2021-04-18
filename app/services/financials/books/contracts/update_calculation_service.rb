class Financials::Books::Contracts::UpdateCalculationService
  
  def initialize(contract, date)
    @contract = contract
    @taker = @contract.taker
    @date = date
    @calculation = calculation
    @receivables = receivables
    @adjustments = adjustments

    update_calculation
  end

  def receivables
    ::Financials::Books::Receivables::EntityRepository.all_active_by_date_and_contracts(@date.id, @taker.contracts.ids)
  end

  def adjustments
    ::Financials::Books::Receivables::AdjustmentRepository.all_active_by_date_and_contracts(@date.id, @taker.contracts.ids)
  end

  def calculation
    ::Financials::Books::Contracts::CalculationRepository.find_by_date_and_taker(@date.id, @contract.taker_id)
  end

  def update_calculation
    @calculation.total_income_amount = @receivables.select{|r| r.kind == "income"}.map{|r| r.amount}.sum
    @calculation.total_refund_amount = @adjustments.select{|a| a.kind == "refund"}.map{|a| a.amount}.sum
    @calculation.total_discount_amount = @adjustments.select{|a| a.kind == "discount"}.map{|a| a.amount}.sum
    @calculation.total_reversal_amount = @adjustments.select{|a| a.kind == "reversal"}.map{|a| a.amount}.sum
    @calculation.total_error_amount = @adjustments.select{|a| a.kind == "error"}.map{|a| a.amount}.sum

    @calculation.total_invoice_amount = @calculation.total_income_amount - @calculation.total_discount_amount
    @calculation.final_amount = @calculation.total_income_amount + @calculation.total_refund_amount - @calculation.total_discount_amount - @calculation.total_reversal_amount - @calculation.total_error_amount

    @calculation.total_income_received_amount = @receivables.select{|r| r.status == "received" && r.kind == "income"}.map{|r| r.amount}.sum
    @calculation.total_refund_received_amount = @adjustments.select{|a| a.status == "received" && a.kind == "refund"}.map{|a| a.amount}.sum
    @calculation.total_discount_received_amount = @adjustments.select{|a| a.status == "received" && a.kind == "discount"}.map{|a| a.amount}.sum
    @calculation.total_reversal_received_amount = @adjustments.select{|a| a.status == "received" && a.kind == "reversal"}.map{|a| a.amount}.sum
    @calculation.total_error_received_amount = @adjustments.select{|a| a.status == "received" && a.kind == "error"}.map{|a| a.amount}.sum

    @calculation.total_invoice_received_amount = @calculation.total_income_received_amount - @calculation.total_discount_received_amount
    @calculation.total_received_amount = @calculation.total_income_received_amount + @calculation.total_refund_received_amount - @calculation.total_discount_received_amount - @calculation.total_reversal_received_amount - @calculation.total_error_received_amount
    
    @calculation.save
  end

end