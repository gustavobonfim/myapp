class Financials::Books::Payables::Entities::List

  def initialize(params)
    @payable_params = params.require(:payable).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_payable = can_current_user_list_payable?
    # return false unless @can_current_user_list_payable

    @payables = payables
  end

  def payables
    ::Financials::Books::Payables::EntityRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_payable
    @status
  end

  def process?
    # return false unless @can_current_user_list_payable
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_payable
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_payable
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_payable
    cln = ::Financials::Books::Payables::EntityRepository.list(@payables)

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

  def can_current_user_list_payable?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_payable_entities").can_current_user?
  end

end