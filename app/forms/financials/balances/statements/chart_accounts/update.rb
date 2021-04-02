class Financials::Balances::Statements::ChartAccounts::Update

  def initialize(params)
    @chart_account_params = params.require(:chart_account).permit(:id, :name, :code, :master_name, :group, :master_group, :master, :accounting, :deductibility)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_update_chart_account = can_current_user_update_chart_account?
    # return false unless @can_current_user_update_chart_account
    
    prepare_code
    @chart_account = chart_account
    @valid = @chart_account.valid?
  end

  def chart_account
    ::Financials::Balances::Statements::ChartAccountRepository.find_and_change(@chart_account_params)
  end
  
  def save
    # return false unless @can_current_user_update_chart_account
    ActiveRecord::Base.transaction do
      if @valid
        @chart_account.save

        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        true
      else
        @data = false
        @status = false
        @process = false
        @type = false
        @message = false
        false
      end
    end
  end
  
  def data
    # return cln = [] unless @can_current_user_update_chart_account
    if @data
      cln = ::Financials::Balances::Statements::ChartAccountRepository.read(@chart_account)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_chart_account
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_chart_account
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_chart_account
    if @message
      message = "Lead criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @chart_account.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_update_chart_account?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", "financial_statement_chart_accounts").can_current_user?
  end

  def prepare_code
    
    if @chart_account_params["code"].to_i < 10
      @chart_account_params = @chart_account_params.merge({ "code" => "0#{@chart_account_params["code"]}" })      
    end
    
  end

end
