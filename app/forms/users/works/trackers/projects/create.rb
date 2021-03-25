class Users::Works::Trackers::Projects::Create

  def initialize(params)
    @project_params = params.require(:project).permit(:name, :description, :unit, :status, :started_at)
    @squad_params = params.require(:squad).permit(:team_name, :team_id, :role)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_project = can_current_user_create_project?
    # return false unless @can_current_user_create_project

    @project = project

    @valid = @project.valid?
  end

  def project
    ::Users::Works::Trackers::ProjectRepository.build(@project_params)
  end
  
  def save
    # return false unless @can_current_user_create_project
    ActiveRecord::Base.transaction do
      if @valid 
        @project.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        @squad_params = @squad_params.merge({ "project_id" => @project.id })
        ::Users::Works::Trackers::Projects::CreateSquadService.new(@squad_params).create_squad

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
    # return cln = [] unless @can_current_user_create_project
    if @data
      cln = ::Users::Works::Trackers::ProjectRepository.read(@project)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_project
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_project
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_project
    if @message
      message = "Estágio  atualizado com sucesso!"
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

  def can_current_user_create_project?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "user_works_trackers_projects").can_current_user?
  end

end
