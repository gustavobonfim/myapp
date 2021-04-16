class Financials::Books::Receivables::Entities::Create

  def initialize(params)
    @receivable_params = params.require(:receivable).permit(:contract_id, :date_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_receivable = can_current_user_create_receivable?
    # return false unless @can_current_user_create_receivable    
    
    # date = ::Financials::Config::FindOrCreateDateService.new(@receivable_params[:due_date]).find_or_create_date
    # @receivable_params = @receivable_params.merge({ "date_id" => date.id })
  
    @contract = contract
    @date = date
    @valid = @contract.valid?
  end

  def contract
    ::Financials::Books::Contracts::EntityRepository.find_by_id(@receivable_params[:contract_id])
  end

  def date
    ::Financials::Config::DateRepository.find_by_id(@receivable_params[:date_id])
  end
  
  def save
    # return false unless @can_current_user_create_receivable
    ActiveRecord::Base.transaction do
      @receivable = ::Financials::Books::Contracts::CreateContractReceivableService.new(@contract, @date).create_contract_receivable

      if @receivable.id

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
    # return cln = [] unless @can_current_user_create_receivable
    if @data




      debugger





      cln = ::Financials::Books::Receivables::EntityRepository.read(@receivable)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_receivable
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_receivable
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_receivable
    if @message
      message = "Recebível criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @receivable.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_receivable?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "financial_receivable_entities").can_current_user?
  end

end
