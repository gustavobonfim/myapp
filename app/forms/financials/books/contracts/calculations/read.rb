class Financials::Books::Contracts::Calculations::Read

  def initialize(params)
    @calculation_params = params.require(:calculation).permit(:id, :active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_read_calculation = can_current_user_read_calculation?
    # return false unless @can_current_user_read_calculation

    @calculation = calculation
  end

  def calculation
    ::Financials::Books::Contracts::CalculationRepository.find_by_id(@calculation_params[:id])
  end

  def status
    # return :forbidden unless @can_current_user_read_calculation
    @status
  end

  def process?
    # return false unless @can_current_user_read_calculation
    @process
  end

  def type
    # return "danger" unless @can_current_user_read_calculation
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_read_calculation
    @message
  end

  def data
    # return cln = [] unless @can_current_user_read_calculation
    cln = ::Financials::Books::Contracts::CalculationRepository.read(@calculation)

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

  def can_current_user_read_calculation?
    ::UserPolicies.new(@current_user_params[:current_user_id], "read", "financial_contract_calculations").can_current_user?
  end

end