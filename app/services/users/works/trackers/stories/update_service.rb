class Users::Works::Trackers::Stories::UpdateService

  def initialize(obj)
    @obj = obj

    if @obj.class.name == "User::Work::Tracker::Relation"
      @story_precedent = @obj.precedent
      @story_dependent = @obj.dependent
    elsif @obj.class.name == "User::Work::Tracker::Story"
    end
    
  end

  def update_story

    if @obj.class.name == "User::Work::Tracker::Relation"
      total_dependents = ::Users::Works::Trackers::RelationRepository.all_active_precedents(@story_precedent.id)
      total_precedents = ::Users::Works::Trackers::RelationRepository.all_active_dependents(@story_dependent.id)

      @story_precedent.total_dependents = total_dependents.size
      @story_dependent.total_precedents = total_precedents.size

      @story_precedent.save
      @story_dependent.save
    elsif @obj.class.name == "User::Work::Tracker::Story"
      total_stories = ::Users::Works::Trackers::StoryRepository.all_active_by_project(@project.id)

      @project.total_stories = total_stories.size
    end
    
    return @obj
  end
  
end