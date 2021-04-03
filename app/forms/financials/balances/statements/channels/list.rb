class Financials::Balances::Statements::Channels::List

  def initialize(params)
    @channel_params = params.require(:channel).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_channel = can_current_user_list_channel?
    # return false unless @can_current_user_list_channel

    @channels = channels
  end

  def channels
    ::Financials::Balances::Statements::ChannelRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_channel
    @status
  end

  def process?
    # return false unless @can_current_user_list_channel
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_channel
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_channel
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_channel
    cln = ::Financials::Balances::Statements::ChannelRepository.list(@channels)

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

  def can_current_user_list_channel?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "financial_statement_channels").can_current_user?
  end

end