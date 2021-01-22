class Commercial::Config::Dates::Read

  def initialize(params)
    @date_params = params.require(:date).permit(:date)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_read_date = can_current_user_read_date?
    # return false unless @can_current_user_read_date

    @date = date
  end

  def date
    ::Commercial::Config::FindOrCreateDateService.new(@date_params[:date]).find_or_create_date
  end

  def status
    # return :forbidden unless @can_current_user_read_date
    @status
  end

  def process?
    # return false unless @can_current_user_read_date
    @process
  end

  def type
    # return "danger" unless @can_current_user_read_date
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_read_date
    @message
  end

  def data
    # return cln = [] unless @can_current_user_read_date
    cln = ::Commercial::Config::DateRepository.read(@date)

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

  def can_current_user_read_date?
    ::UserPolicies.new(@current_user_params[:current_user_id], "read", "medbooking_date").can_current_user?
  end

end