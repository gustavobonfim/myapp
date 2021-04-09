class Financials::Books::Settings::Channels::Update

  def initialize(params)
    @channel_params = params.require(:channel).permit(:id, :name, :kind, :med_id, :chart_id, :card_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_update_channel = can_current_user_update_channel?
    # return false unless @can_current_user_update_channel
    
    @channel = channel
    @valid = @channel.valid?
  end

  def channel
    ::Financials::Books::Settings::ChannelRepository.find_and_change(@channel_params)
  end
  
  def save
    # return false unless @can_current_user_update_channel
    ActiveRecord::Base.transaction do
      if @valid
        @channel.save

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
    # return cln = [] unless @can_current_user_update_channel
    if @data
      cln = ::Financials::Books::Settings::ChannelRepository.read(@channel)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_channel
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_channel
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_channel
    if @message
      message = "Canal Pagamento criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @channel.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_update_channel?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", "financial_setting_channels").can_current_user?
  end

end
