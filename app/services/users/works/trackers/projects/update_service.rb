class Users::Works::Trackers::Projects::UpdateService

  def initialize(obj)
    @obj = obj

    if @obj.class.name == "User::Work::Tracker::Squad"
      @project = @obj.project
    end
    
  end

  def update_project

    if @obj.class.name == "User::Work::Tracker::Squad"
      total_squads = Users::Works::Trackers::SquadRepository.all_active_by_project(@project.id)

      @project.total_squads = total_squads.size
    end
    
    @project.save
    return @project
  end
  
end