class Financials::Books::Receivables::Adjustments::Create

  def initialize(params)
    @adjustment_params = params.require(:adjustment).permit(:contract_id, :date_id, :med_id, :contract_token, :due_date, :amount, :description, :kind)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_adjustment = can_current_user_create_adjustment?
    # return false unless @can_current_user_create_adjustment    
    
    # date = ::Financials::Config::FindOrCreateDateService.new(@adjustment_params[:due_date]).find_or_create_date
    # @adjustment_params = @adjustment_params.merge({ "date_id" => date.id })
  
    @adjustment = adjustment
    @valid = @adjustment.valid?
  end

  def adjustment
    ::Financials::Books::Receivables::AdjustmentRepository.build(@adjustment_params)
  end
  
  def save
    # return false unless @can_current_user_create_adjustment
    ActiveRecord::Base.transaction do
      
      if @valid
        @adjustment.save

        ::Financials::Books::Receivables::Adjustments::CreateTransactionService.new(@adjustment).create_transaction
        ::Financials::Books::Contracts::UpdateCalculationService.new(@adjustment.contract, @adjustment.financial_date)
        ::Financials::Books::Receivables::Calculations::UpdateService.new(@adjustment.contract.med, @adjustment.financial_date)

        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        true
      else
        @data = false
        @status = false
        @process = false
        @type = false
        @message = false
        false
      end
    end
  end
  
  def data
    # return cln = [] unless @can_current_user_create_adjustment
    if @data
      cln = ::Financials::Books::Receivables::AdjustmentRepository.read(@adjustment)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_adjustment
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_adjustment
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_adjustment
    if @message
      message = "Ajuste criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @adjustment.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_adjustment?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "financial_receivable_adjustments").can_current_user?
  end

end
