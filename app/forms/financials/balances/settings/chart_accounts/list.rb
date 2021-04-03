class Financials::Balances::Settings::ChartAccounts::List

  def initialize(params)
    @chart_account_params = params.require(:chart_account).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_chart_account = can_current_user_list_chart_account?
    # return false unless @can_current_user_list_chart_account

    @chart_accounts = chart_accounts
  end

  def chart_accounts
    ::Financials::Balances::Settings::ChartAccountRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_chart_account
    @status
  end

  def process?
    # return false unless @can_current_user_list_chart_account
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_chart_account
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_chart_account
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_chart_account
    cln = ::Financials::Balances::Settings::ChartAccountRepository.list(@chart_accounts)

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

  def can_current_user_list_chart_account?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_setting_chart_accounts").can_current_user?
  end

end