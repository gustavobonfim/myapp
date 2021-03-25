class Users::Works::Trackers::Projects::UpdateService

  def initialize(obj)
    @obj = obj

    @project = @obj.project
    # if @obj.class.name == "User::Work::Tracker::Squad"
    # elsif @obj.class.name == "User::Work::Tracker::Story"
    # end
    
  end

  def update_project

    if @obj.class.name == "User::Work::Tracker::Squad"
      total_squads = Users::Works::Trackers::SquadRepository.all_active_by_project(@project.id)

      @project.total_squads = total_squads.size
    elsif @obj.class.name == "User::Work::Tracker::Story"
      total_stories = Users::Works::Trackers::StoryRepository.all_active_by_project(@project.id)

      @project.total_stories = total_stories.size
    end
    
    @project.save
    return @project
  end
  
end