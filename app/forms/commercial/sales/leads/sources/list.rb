class Commercial::Sales::Leads::Sources::List

  def initialize(params)
    @source_params = params.require(:source).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_source = can_current_user_list_source?
    # return false unless @can_current_user_list_source

    @sources = sources
  end

  def sources
    ::Commercial::Sales::Leads::SourceRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_source
    @status
  end

  def process?
    # return false unless @can_current_user_list_source
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_source
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_source
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_source
    cln = ::Commercial::Sales::Leads::SourceRepository.list(@sources)

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

  def can_current_user_list_source?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medbooking_sources").can_current_user?
  end

end