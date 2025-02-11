class Users::Works::Trackers::Projects::Update

  def initialize(params)
    @project_params = params.require(:project).permit(:id, :name, :description, :unit, :status, :started_at)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_update_project = can_current_user_update_project?
    # return false unless @can_current_user_update_project

    @project = project

    @valid = @project.valid?
  end

  def project
    ::Users::Works::Trackers::ProjectRepository.find_and_change(@project_params)
  end
  
  def save
    # return false unless @can_current_user_update_project
    ActiveRecord::Base.transaction do
      if @valid 
        @project.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        true
      else
        @data = false
        @status = false
        @process = false
        @type = false
        @message = false
        false
      end
    end
  end
  
  def data
    # return cln = [] unless @can_current_user_update_project
    if @data
      cln = ::Users::Works::Trackers::ProjectRepository.read(@project)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_project
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_project
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_project
    if @message
      message = "Projeto atualizado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @project.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_update_project?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", "user_works_trackers_projects").can_current_user?
  end

end
