class Financials::Books::Contracts::Additives::Update

  def initialize(params)
    @additive_params = params.require(:additive).permit(:id, :date, :description, :amount, :kind)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_update_additive = can_current_user_update_additive?
    # return false unless @can_current_user_update_additive
  
    @additive = additive
    @valid = @additive.valid?
  end

  def additive
    ::Financials::Books::Contracts::AdditiveRepository.find_and_change(@additive_params)
  end
  
  def save
    # return false unless @can_current_user_update_additive
    ActiveRecord::Base.transaction do
      if @valid 
        @additive.save

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
    # return cln = [] unless @can_current_user_update_additive
    if @data
      cln = ::Financials::Books::Contracts::AdditiveRepository.read(@additive)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_additive
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_additive
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_additive
    if @message
      message = "Aditivo criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @additive.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_update_additive?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", "financial_contract_additives").can_current_user?
  end

end
