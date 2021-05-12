class Operations::Onboards::Entities::List

  def initialize(params)
    @onboard_params = params.require(:onboard).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_onboard = can_current_user_list_onboard?
    # return false unless @can_current_user_list_onboard

    @onboards = onboards
  end

  def onboards
    ::Operations::Onboards::EntityRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_onboard
    @status
  end

  def process?
    # return false unless @can_current_user_list_onboard
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_onboard
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_onboard
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_onboard
    cln = ::Operations::Onboards::EntityRepository.list(@onboards)

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

  def can_current_user_list_onboard?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "operation_onboard_entities").can_current_user?
  end

end