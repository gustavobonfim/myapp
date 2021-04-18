class Financials::Books::Contracts::Takers::List

  def initialize(params)
    @taker_params = params.require(:taker).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_taker = can_current_user_list_taker?
    # return false unless @can_current_user_list_taker

    @takers = takers
  end

  def takers
    ::Financials::Books::Contracts::TakerRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_taker
    @status
  end

  def process?
    # return false unless @can_current_user_list_taker
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_taker
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_taker
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_taker
    cln = ::Financials::Books::Contracts::TakerRepository.list(@takers)

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

  def can_current_user_list_taker?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_contract_takers").can_current_user?
  end

end