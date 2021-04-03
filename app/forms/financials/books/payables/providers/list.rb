class Financials::Books::Payables::Providers::List

  def initialize(params)
    @provider_params = params.require(:provider).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_provider = can_current_user_list_provider?
    # return false unless @can_current_user_list_provider

    @providers = providers
  end

  def providers
    ::Financials::Books::Payables::ProviderRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_provider
    @status
  end

  def process?
    # return false unless @can_current_user_list_provider
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_provider
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_provider
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_provider
    cln = ::Financials::Books::Payables::ProviderRepository.list(@providers)

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

  def can_current_user_list_provider?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_payable_providers").can_current_user?
  end

end