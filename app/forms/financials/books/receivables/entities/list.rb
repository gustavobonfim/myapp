class Financials::Books::Receivables::Entities::List

  def initialize(params)
    @receivable_params = params.require(:receivable).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_receivable = can_current_user_list_receivable?
    # return false unless @can_current_user_list_receivable

    @receivables = receivables
  end

  def receivables
    ::Financials::Books::Receivables::EntityRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_receivable
    @status
  end

  def process?
    # return false unless @can_current_user_list_receivable
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_receivable
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_receivable
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_receivable
    cln = ::Financials::Books::Receivables::EntityRepository.list(@receivables)

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

  def can_current_user_list_receivable?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_receivable_entities").can_current_user?
  end

end