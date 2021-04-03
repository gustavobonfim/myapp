class Financials::Books::Balances::Entities::List

  def initialize(params)
    @balance_params = params.require(:balance).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_balance = can_current_user_list_balance?
    # return false unless @can_current_user_list_balance

    @balances = balances
  end

  def balances
    ::Financials::Books::Balances::EntityRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_balance
    @status
  end

  def process?
    # return false unless @can_current_user_list_balance
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_balance
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_balance
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_balance
    cln = ::Financials::Books::Balances::EntityRepository.list(@balances)

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

  def can_current_user_list_balance?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_balance_entities").can_current_user?
  end

end