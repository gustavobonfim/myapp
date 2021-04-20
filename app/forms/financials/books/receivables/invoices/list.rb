class Financials::Books::Receivables::Invoices::List

  def initialize(params)
    @invoice_params = params.require(:invoice).permit(:active, :contract_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_invoice = can_current_user_list_invoice?
    # return false unless @can_current_user_list_invoice

    @invoices = invoices
  end

  def invoices
    # ::Financials::Books::Receivables::InvoiceRepository.all_active_by_contract(@invoice_params[:contract_id])
    ::Financials::Books::Receivables::InvoiceRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_invoice
    @status
  end

  def process?
    # return false unless @can_current_user_list_invoice
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_invoice
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_invoice
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_invoice
    cln = ::Financials::Books::Receivables::InvoiceRepository.list(@invoices)

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

  def can_current_user_list_invoice?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_receivable_invoices").can_current_user?
  end

end