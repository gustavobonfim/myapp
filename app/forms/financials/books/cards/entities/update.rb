class Financials::Books::Cards::Entities::Update

  def initialize(params)
    @card_params = params.require(:card).permit(:id, :name, :pay_day, :closing_day, :med_id, :last_four,
                                                :credit_limit, :channel_name, :provider_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_update_card = can_current_user_update_card?
    # return false unless @can_current_user_update_card
  
    @card = card
    @valid = @card.valid?
  end

  def card
    ::Financials::Books::Cards::EntityRepository.find_and_change(@card_params)
  end
  
  def save
    # return false unless @can_current_user_update_card
    ActiveRecord::Base.transaction do
      if @valid
        @card.save
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
    # return cln = [] unless @can_current_user_update_card
    if @data
      cln = ::Financials::Books::Cards::EntityRepository.read(@card)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_card
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_card
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_card
    if @message
      message = "Cartão de Crédito criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @card.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_update_card?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", "financial_card_entities").can_current_user?
  end

end
