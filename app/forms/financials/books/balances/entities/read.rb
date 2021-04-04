class Financials::Books::Balances::Entities::Read

  def initialize(params)
    @balance_params = params.require(:balance).permit(:id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_read_balance = can_current_user_read_balance?
    # return false unless @can_current_user_read_balance

    @balance = balance
  end

  def balance
    ::Financials::Books::Balances::EntityRepository.find_by_id(@balance_params[:id])
  end

  def status
    # return :forbidden unless @can_current_user_read_balance
    @status
  end

  def process?
    # return false unless @can_current_user_read_balance
    @process
  end

  def type
    # return "danger" unless @can_current_user_read_balance
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_read_balance
    @message
  end

  def data
    # return cln = [] unless @can_current_user_read_balance
    cln = ::Financials::Books::Balances::EntityRepository.read(@balance)

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

  def can_current_user_read_balance?
    ::UserPolicies.new(@current_user_params[:current_user_id], "read", "financial_balance_entities").can_current_user?
  end

end