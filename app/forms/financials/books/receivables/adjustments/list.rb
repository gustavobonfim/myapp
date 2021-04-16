class Financials::Books::Receivables::Adjustments::List

  def initialize(params)
    @adjustment_params = params.require(:adjustment).permit(:active, :contract_id, :date_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_adjustment = can_current_user_list_adjustment?
    # return false unless @can_current_user_list_adjustment

    @adjustments = adjustments
  end

  def adjustments
    ::Financials::Books::Receivables::AdjustmentRepository.all_active_by_date_and_contract(@adjustment_params[:date_id], @adjustment_params[:contract_id])
  end

  def status
    # return :forbidden unless @can_current_user_list_adjustment
    @status
  end

  def process?
    # return false unless @can_current_user_list_adjustment
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_adjustment
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_adjustment
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_adjustment
    cln = ::Financials::Books::Receivables::AdjustmentRepository.list(@adjustments)

    if cln.empty?
      @status = :ok
      @process = false
      @message = ""
      @type = "danger"
    else
      @status = :ok
      @process = true
      @message = ""
      @type = "success"
    end
    
    return {:cln => cln.compact}.as_json
  end

  private

  def can_current_user_list_adjustment?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_receivable_adjustments").can_current_user?
  end

end