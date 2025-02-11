class Financials::Books::Receivables::Invoices::Create

  def initialize(params)
    @invoice_params = params.require(:invoice).permit(:contract_id)
    @receivable_params = params.require(:receivable).permit(:ids => [])
    @adjustment_params = params.require(:adjustment).permit(:ids => [])
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_invoice = can_current_user_create_invoice?
    # return false unless @can_current_user_create_invoice

    @can_create_invoice = can_create_invoice
    @invoice = invoice
    @valid = @invoice.valid? && @can_create_invoice
  end

  def invoice
    ::Financials::Books::Receivables::InvoiceRepository.build(@invoice_params)
  end
  
  def save
    # return false unless @can_current_user_create_invoice
    ActiveRecord::Base.transaction do
      
      if @valid
        @invoice.save
        ::Financials::Books::Receivables::Invoices::CreateConciliationService.new(@invoice, @receivable_params[:ids], @adjustment_params[:ids]).create_concilation

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
      return :created
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
      message = "Fatura criada com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 1
      @invoice.errors.messages.each do |key, value|
        message += " (#{i}) #{value.first}"
        i += 1
      end
      message += " (#{i}) Existe uma fatura pendente para o Contrato" unless @can_create_invoice
      return message
    end
  end

  private

  def can_create_invoice
    ::Financials::Books::Receivables::InvoiceRepository.has_not_pending_invoice(@invoice_params[:contract_id])
  end
  

  def can_current_user_create_invoice?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "financial_receivable_invoices").can_current_user?
  end

end
