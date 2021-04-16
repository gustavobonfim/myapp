class Financials::Books::Contracts::Entities::Read

  def initialize(params)
    @contract_params = params.require(:contract).permit(:id, :active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_read_contract = can_current_user_read_contract?
    # return false unless @can_current_user_read_contract

    @contract = contract
  end

  def contract
    ::Financials::Books::Contracts::EntityRepository.find_by_id(@contract_params[:id])
  end

  def status
    # return :forbidden unless @can_current_user_read_contract
    @status
  end

  def process?
    # return false unless @can_current_user_read_contract
    @process
  end

  def type
    # return "danger" unless @can_current_user_read_contract
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_read_contract
    @message
  end

  def data
    # return cln = [] unless @can_current_user_read_contract
    cln = ::Financials::Books::Contracts::EntityRepository.read(@contract)

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

  def can_current_user_read_contract?
    ::UserPolicies.new(@current_user_params[:current_user_id], "read", "financial_contract_entities").can_current_user?
  end

end