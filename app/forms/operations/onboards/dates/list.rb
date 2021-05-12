class Operations::Onboards::Dates::List

  def initialize(params)
    @date_params = params.require(:date).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_date = can_current_user_list_date?
    # return false unless @can_current_user_list_date

    @dates = dates
  end

  def dates
    ::Operations::Onboards::DateRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_date
    @status
  end

  def process?
    # return false unless @can_current_user_list_date
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_date
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_date
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_date
    cln = ::Operations::Onboards::DateRepository.list(@dates)

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

  def can_current_user_list_date?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "operation_onboard_dates").can_current_user?
  end

end