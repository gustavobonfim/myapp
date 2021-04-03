class Financials::Balances::Statements::Transactions::List

  def initialize(params)
    @transaction_params = params.require(:transaction).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_transaction = can_current_user_list_transaction?
    # return false unless @can_current_user_list_transaction

    @transactions = transactions
  end

  def transactions
    ::Financials::Balances::Statements::TransactionRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_transaction
    @status
  end

  def process?
    # return false unless @can_current_user_list_transaction
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_transaction
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_transaction
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_transaction
    cln = ::Financials::Balances::Statements::TransactionRepository.list(@transactions)

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

  def can_current_user_list_transaction?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_statement_transactions").can_current_user?
  end

end