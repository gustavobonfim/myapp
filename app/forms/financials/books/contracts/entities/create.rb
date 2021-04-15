class Financials::Books::Contracts::Entities::Create

  def initialize(params)
    @contract_params = params.require(:contract).permit(:taker_id, :client_id, :product_name, :product_service, :product_kind,
                                                        :kind, :plan, :status, :monthly, :yearly, :amount, :prepaid, :method,
                                                        :due_day, :started_at, :start_month, :start_year, :channel_id, :med_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_contract = can_current_user_create_contract?
    # return false unless @can_current_user_create_contract    
    
    @date = ::Financials::Config::FindOrCreateDateService.new(@contract_params[:started_at]).find_or_create_date
    # @contract_params = @contract_params.merge({ "record_type" => ::Financials::Books::Contracts::EntityRepository::ENUM_KIND_TO_SCHEMA[@contract_params[:id_type]] })
  
    @contract = contract
    @valid = @contract.valid?
  end

  def contract
    ::Financials::Books::Contracts::EntityRepository.build(@contract_params)
  end
  
  def save
    # return false unless @can_current_user_create_contract
    ActiveRecord::Base.transaction do
      if @valid 
        @contract.save
        ::Financials::Books::Contracts::CreateContractReceivableService.new(@contract, @date)

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
    # return cln = [] unless @can_current_user_create_contract
    if @data
      cln = ::Financials::Books::Contracts::EntityRepository.read(@contract)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_contract
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_contract
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_contract
    if @message
      message = "Contrato Financeiro criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @contract.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_contract?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "financial_contract_entities").can_current_user?
  end

end
