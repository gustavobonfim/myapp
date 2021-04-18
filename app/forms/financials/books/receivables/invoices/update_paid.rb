class Financials::Books::Receivables::Invoices::UpdatePaid

  def initialize(params)
    @invoice_params = params.require(:invoice).permit(:id, :status)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_invoice = can_current_user_create_invoice?
    # return false unless @can_current_user_create_invoice
  
    @invoice = invoice
    @valid = @invoice.valid?
  end

  def invoice
    ::Financials::Books::Receivables::InvoiceRepository.find_and_change(@invoice_params)
  end
  
  def save
    # return false unless @can_current_user_create_invoice
    ActiveRecord::Base.transaction do
      
      if @valid
        @invoice.save

        ::Financials::Books::Receivables::UpdatePaidInvoiceService.new(@invoice)
        # ::Financials::Books::Contracts::UpdateCalculationService.new(@invoice.contract, @invoice.financial_date)
        # ::Financials::Books::Receivables::Calculations::UpdateService.new(@invoice.contract.med, @invoice.financial_date)

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
    # return cln = [] unless @can_current_user_create_invoice
    if @data
      cln = ::Financials::Books::Receivables::InvoiceRepository.read(@invoice)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_invoice
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_invoice
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_invoice
    if @message
      message = "Ajuste criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @invoice.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_invoice?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "financial_receivable_invoices").can_current_user?
  end

end
