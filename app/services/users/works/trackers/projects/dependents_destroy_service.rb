class Users::Works::Trackers::Projects::DependentsDestroyService

  def initialize(project)
    @project = project
  end

  def destroy
    # project = ::Users::Works::Trackers::ProjectRepository.find_by_id(@project.id)
    
    User::Work::Tracker::Squad.where(project_id: @project.id).destroy_all
    User::Work::Tracker::Story.where(project_id: @project.id).destroy_all
    User::Work::Tracker::Journey.where(project_id: @project.id).destroy_all
  end
  
  


end