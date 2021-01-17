class Commercial::Sales::Opportunities::Journeys::Update

  def initialize(params)
    @journey_params = params.require(:journey).permit(:id, :active, :date)
    # @notification_params = params.require(:notification).permit(:domain_id, :domain_type, :date_id, :date_type, :kind, :user_name, :user_id, :action)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_update_journey = can_current_user_update_journey?
    # return false unless @can_current_user_update_journey

    @journey = journey
    @valid = @journey.valid?
  end

  def journey
    ::Commercial::Sales::Opportunities::JourneyRepository.find_and_change(@journey_params)
  end

  def date
    ::Commercial::Config::DateRepository.find_or_initialize(Date.current)
  end
  
  def save
    # return false unless @can_current_user_update_journey
    ActiveRecord::Base.transaction do
      if @valid 
        @journey.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        ::Commercial::Sales::Opportunities::UpdateOpportunityService.new(@journey.opportunity).update_opportunity

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
    # return cln = [] unless @can_current_user_update_journey
    if @data
      cln = ::Commercial::Sales::Opportunities::JourneyRepository.read(@journey)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_journey
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_journey
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_journey
    if @message
      message = "Produto adicionado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @journey.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_update_journey?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", "commercial_sales_journeys").can_current_user?
  end

end
