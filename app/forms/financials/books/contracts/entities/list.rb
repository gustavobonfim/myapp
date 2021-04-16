class Financials::Books::Contracts::Entities::List

  def initialize(params)
    @contract_params = params.require(:contract).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_contract = can_current_user_list_contract?
    # return false unless @can_current_user_list_contract

    @contracts = contracts
  end

  def contracts
    ::Financials::Books::Contracts::EntityRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_contract
    @status
  end

  def process?
    # return false unless @can_current_user_list_contract
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_contract
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_contract
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_contract
    cln = ::Financials::Books::Contracts::EntityRepository.list(@contracts)

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

  def can_current_user_list_contract?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_contract_entities").can_current_user?
  end

end