class Commercial::Sales::Opportunities::Entities::Read

  def initialize(params)
    @opportunity_params = params.require(:opportunity).permit(:id, :token)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_read_opportunity = can_current_user_read_opportunity?
    # return false unless @can_current_user_read_opportunity

    @opportunity = opportunity
  end

  def opportunity
    if @opportunity_params[:id]
      ::Commercial::Sales::Opportunities::EntityRepository.find_by_id(@opportunity_params[:id])
    elsif @opportunity_params[:token]
      ::Commercial::Sales::Opportunities::EntityRepository.find_by_token(@opportunity_params[:token])
    end
  end

  def status
    # return :forbidden unless @can_current_user_read_opportunity
    @status
  end

  def process?
    # return false unless @can_current_user_read_opportunity
    @process
  end

  def type
    # return "danger" unless @can_current_user_read_opportunity
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_read_opportunity
    @message
  end

  def data
    # return cln = [] unless @can_current_user_read_opportunity
    cln = ::Commercial::Sales::Opportunities::EntityRepository.read(@opportunity)

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

  def can_current_user_read_opportunity?
    ::UserPolicies.new(@current_user_params[:current_user_id], "read", "medbooking_opportunity").can_current_user?
  end

end