class Financials::Books::Contracts::Takers::Create

  def initialize(params)
    @taker_params = params.require(:taker).permit(:name, :record_id, :record_type, :id_number, :id_type)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_taker = can_current_user_create_taker?
    # return false unless @can_current_user_create_taker    
    
    @date = ::Financials::Config::FindOrCreateDateService.new(Date.current).find_or_create_date
    @taker_params = @taker_params.merge({ "record_type" => ::Financials::Books::Contracts::TakerRepository::ENUM_KIND_TO_SCHEMA[@taker_params[:id_type]] })
  
    @taker = taker
    @valid = @taker.valid?
  end

  def taker
    ::Financials::Books::Contracts::TakerRepository.build(@taker_params)
  end
  
  def save
    # return false unless @can_current_user_create_taker
    ActiveRecord::Base.transaction do
      if @valid 
        @taker.save
        ::Financials::Books::Contracts::CreateCalculationService.new(@date, @taker.id)

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
    # return cln = [] unless @can_current_user_create_taker
    if @data
      cln = ::Financials::Books::Contracts::TakerRepository.read(@taker)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_taker
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_taker
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_taker
    if @message
      message = "Tomador criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @taker.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_taker?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "financial_contract_takers").can_current_user?
  end

end
