class Financials::Books::Statements::Calculations::List

  def initialize(params)
    @calculation_params = params.require(:calculation).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_calculation = can_current_user_list_calculation?
    # return false unless @can_current_user_list_calculation

    @calculations = calculations
  end

  def calculations
    ::Financials::Books::Statements::CalculationRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_calculation
    @status
  end

  def process?
    # return false unless @can_current_user_list_calculation
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_calculation
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_calculation
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_calculation
    cln = ::Financials::Books::Statements::CalculationRepository.list(@calculations)

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

  def can_current_user_list_calculation?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_statement_calculations").can_current_user?
  end

end