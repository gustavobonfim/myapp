class Users::Works::Trackers::Projects::Read

  def initialize(params)
    @project_params = params.require(:project).permit(:id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_read_project = can_current_user_read_project?
    # return false unless @can_current_user_read_project

    @project = project
  end

  def project
    ::Users::Works::Trackers::ProjectRepository.find_by_id(@project_params[:id])
  end

  def status
    # return :forbidden unless @can_current_user_read_project
    @status
  end

  def process?
    # return false unless @can_current_user_read_project
    @process
  end

  def type
    # return "danger" unless @can_current_user_read_project
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_read_project
    @message
  end

  def data
    # return cln = [] unless @can_current_user_read_project
    cln = ::Users::Works::Trackers::ProjectRepository.read(@project)

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

  def can_current_user_read_project?
    ::UserPolicies.new(@current_user_params[:current_user_id], "read", "user_works_trackers_projects").can_current_user?
  end

end