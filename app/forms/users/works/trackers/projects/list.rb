class Users::Works::Trackers::Projects::List

  def initialize(params)
    @project_params = params.require(:project).permit(:active, :opportunity_id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_project = can_current_user_list_project?
    # return false unless @can_current_user_list_project

    @projects = projects
  end

  def projects
    ::Users::Works::Trackers::ProjectRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_project
    @status
  end

  def process?
    # return false unless @can_current_user_list_project
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_project
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_project
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_project
    cln = ::Users::Works::Trackers::ProjectRepository.list(@projects)

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

  def can_current_user_list_project?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "user_works_trackers_projects").can_current_user?
  end

end