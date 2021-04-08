class Financials::Books::Cards::Bills::List

  def initialize(params)
    @bill_params = params.require(:bill).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_bill = can_current_user_list_bill?
    # return false unless @can_current_user_list_bill

    @bills = bills
  end

  def bills
    ::Financials::Books::Cards::BillRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_bill
    @status
  end

  def process?
    # return false unless @can_current_user_list_bill
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_bill
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_bill
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_bill
    cln = ::Financials::Books::Cards::BillRepository.list(@bills)

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

  def can_current_user_list_bill?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_card_bills").can_current_user?
  end

end