class Financials::Books::Contracts::Additives::List

  def initialize(params)
    @additive_params = params.require(:additive).permit(:active, :contract_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_additive = can_current_user_list_additive?
    # return false unless @can_current_user_list_additive

    @additives = additives
  end

  def additives
    ::Financials::Books::Contracts::AdditiveRepository.all_active_by_contract(@additive_params[:contract_id])
  end

  def status
    # return :forbidden unless @can_current_user_list_additive
    @status
  end

  def process?
    # return false unless @can_current_user_list_additive
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_additive
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_additive
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_additive
    cln = ::Financials::Books::Contracts::AdditiveRepository.list(@additives)

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

  def can_current_user_list_additive?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_contract_additives").can_current_user?
  end

end