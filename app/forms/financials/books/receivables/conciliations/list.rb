class Financials::Books::Receivables::Conciliations::List

  def initialize(params)
    @conciliation_params = params.require(:conciliation).permit(:active, :contract_id, :date_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_conciliation = can_current_user_list_conciliation?
    # return false unless @can_current_user_list_conciliation

    @conciliations = conciliations
  end

  def conciliations
    # ::Financials::Books::Receivables::ConciliationRepository.all_active_by_date_and_contract(@conciliation_params[:date_id], @conciliation_params[:contract_id])
    ::Financials::Books::Receivables::ConciliationRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_conciliation
    @status
  end

  def process?
    # return false unless @can_current_user_list_conciliation
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_conciliation
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_conciliation
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_conciliation
    cln = ::Financials::Books::Receivables::ConciliationRepository.list(@conciliations)

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

  def can_current_user_list_conciliation?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_receivable_conciliations").can_current_user?
  end

end