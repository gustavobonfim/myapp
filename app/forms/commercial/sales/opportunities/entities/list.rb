class Commercial::Sales::Opportunities::Entities::List

  def initialize(params)
    @opportunity_params = params.require(:opportunity).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_opportunity = can_current_user_list_opportunity?
    # return false unless @can_current_user_list_opportunity

    @opportunities = opportunities
  end

  def opportunities
    ::Commercial::Sales::Opportunities::EntityRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_opportunity
    @status
  end

  def process?
    # return false unless @can_current_user_list_opportunity
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_opportunity
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_opportunity
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_opportunity
    cln = ::Commercial::Sales::Opportunities::EntityRepository.list(@opportunities)

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

  def can_current_user_list_opportunity?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medbooking_opportunities").can_current_user?
  end

end