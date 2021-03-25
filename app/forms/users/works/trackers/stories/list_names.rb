class Users::Works::Trackers::Stories::ListNames

  def initialize(params)
    @story_params = params.require(:story).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_story = can_current_user_list_story?
    # return false unless @can_current_user_list_story

    @stories = stories
  end

  def stories
    ::Users::Works::Trackers::StoryRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_story
    @status
  end

  def process?
    # return false unless @can_current_user_list_story
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_story
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_story
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_story
    cln = ::Users::Works::Trackers::StoryRepository.list_names(@stories)

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

  def can_current_user_list_story?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "user_works_trackers_stories").can_current_user?
  end

end