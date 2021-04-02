class Financials::Balances::Payables::Providers::Create

  def initialize(params)
    @provider_params = params.require(:provider).permit(:name, :record_id, :record_type, :id_number, :id_type)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_provider = can_current_user_create_provider?
    # return false unless @can_current_user_create_provider    
    
    # date = ::Commercial::Config::FindOrCreateDateService.new(Date.current).find_or_create_date
    # @lead_params = @lead_params.merge({ "date_id" => date.id })
    # @lead_params = @lead_params.merge({ "uniq_phone" => "#{@lead_params[:prefix]}#{@lead_params[:phone]}" })
  
    @provider = provider
    @valid = @provider.valid?
  end

  def provider
    ::Financials::Balances::Payables::ProviderRepository.build(@provider_params)
  end

  def date
    ::Commercial::Config::DateRepository.find_or_initialize(Date.current)
  end
  
  def save
    # return false unless @can_current_user_create_provider
    ActiveRecord::Base.transaction do
      if @valid 
        @provider.save
        # @source_params = @source_params.merge({ "phone" => @provider.phone })
        # ::Commercial::Sales::Leads::CreateSourceService.new(@source_params).save_source
        # ::Commercial::Config::UpdateCalculationService.new(@provider).update_provider_calculation

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
    # return cln = [] unless @can_current_user_create_provider
    if @data
      cln = ::Financials::Balances::Payables::ProviderRepository.read(@provider)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_provider
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_provider
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_provider
    if @message
      message = "Lead criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @provider.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_provider?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "financial_payable_providers").can_current_user?
  end

end
