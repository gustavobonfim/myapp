class Financials::Books::Cards::Entities::List

  def initialize(params)
    @card_params = params.require(:card).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_card = can_current_user_list_card?
    # return false unless @can_current_user_list_card

    @cards = cards
  end

  def cards
    ::Financials::Books::Cards::EntityRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_card
    @status
  end

  def process?
    # return false unless @can_current_user_list_card
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_card
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_card
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_card
    cln = ::Financials::Books::Cards::EntityRepository.list(@cards)

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

  def can_current_user_list_card?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_card_entities").can_current_user?
  end

end