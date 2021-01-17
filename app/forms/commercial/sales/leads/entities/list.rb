class Commercial::Sales::Leads::Entities::List

  def initialize(params)
    @lead_params = params.require(:lead).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_lead = can_current_user_list_lead?
    # return false unless @can_current_user_list_lead

    @leads = leads
  end

  def leads
    ::Commercial::Sales::Leads::EntityRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_lead
    @status
  end

  def process?
    # return false unless @can_current_user_list_lead
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_lead
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_lead
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_lead
    cln = ::Commercial::Sales::Leads::EntityRepository.list(@leads)

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

  def can_current_user_list_lead?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medbooking_leads").can_current_user?
  end

end