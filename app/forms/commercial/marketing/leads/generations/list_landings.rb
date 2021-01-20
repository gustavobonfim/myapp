class Commercial::Marketing::Leads::Generations::ListLandings

  def initialize(params)
    @lead_params = params.require(:lead).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_leads = can_current_user_list_leads?
    # return false unless @can_current_user_list_leads

    @leadss = leadss
  end

  def leadss
    ::Commercial::Marketing::Landings::LeadRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_leads
    @status
  end

  def process?
    # return false unless @can_current_user_list_leads
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_leads
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_leads
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_leads
    cln = ::Commercial::Marketing::Landings::LeadRepository.lead_gen(@leadss)

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

  def can_current_user_list_leads?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medbooking_leadss").can_current_user?
  end

end