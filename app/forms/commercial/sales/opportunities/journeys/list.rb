class Commercial::Sales::Opportunities::Journeys::List

  def initialize(params)
    @journey_params = params.require(:journey).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_journey = can_current_user_list_journey?
    # return false unless @can_current_user_list_journey

    @journeys = journeys
  end

  def journeys
    ::Commercial::Sales::Opportunities::JourneyRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_journey
    @status
  end

  def process?
    # return false unless @can_current_user_list_journey
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_journey
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_journey
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_journey
    cln = ::Commercial::Sales::Opportunities::JourneyRepository.list(@journeys)

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

  def can_current_user_list_journey?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medbooking_journeys").can_current_user?
  end

end