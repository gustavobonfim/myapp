class Users::Works::Trackers::Stories::Create

  def initialize(params)
    @story_params = params.require(:story).permit(:project_id, :name, :description, :stage, :status, :started_at)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_story = can_current_user_create_story?
    # return false unless @can_current_user_create_story

    @story = story
    @valid = @story.valid?
  end

  def story
    ::Users::Works::Trackers::StoryRepository.build(@story_params)
  end
  
  def save
    # return false unless @can_current_user_create_story
    ActiveRecord::Base.transaction do
      if @valid 
        @story.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        ::Users::Works::Trackers::Projects::UpdateService.new(@story).update_project

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
    # return cln = [] unless @can_current_user_create_story
    if @data
      cln = ::Users::Works::Trackers::StoryRepository.read(@story)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_story
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_story
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_story
    if @message
      message = "Time atualizado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @story.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_story?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "user_works_trackers_stories").can_current_user?
  end

end
