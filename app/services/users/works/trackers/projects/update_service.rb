class Users::Works::Trackers::Projects::UpdateService

  def initialize(obj)
    @obj = obj

    @project = @obj.project

    if @obj.class.name == "User::Work::Tracker::Squad" || @obj.class.name == "User::Work::Tracker::Story"
    elsif @obj.class.name == "User::Work::Activity::Ticket" || @obj.class.name == "User::Work::Activity::Comment"
      ::Operations::Products::Bookings::CalculationRepository.find_by_booking_and_date(@obj.board_id, @obj.date_id)
    elsif @obj.class.name == "User::Account::Note"
      ::Operations::Products::Bookings::CalculationRepository.find_by_booking_and_date(@obj.domain_id, @obj.date_id)
    end
    
  end

  def update_project

    if @obj.class.name == "User::Work::Tracker::Squad"
      total_squads = Users::Works::Trackers::SquadRepository.all_active_by_project(@project.id)

      @project.total_squads = total_squads.size
    elsif @obj.class.name == "User::Work::Tracker::Story"
      total_stories = Users::Works::Trackers::StoryRepository.all_active_by_project(@project.id)

      @project.total_stories = total_stories.size
      @project.total_tickets = total_stories.sum(:total_tickets)
      @project.total_resolved = total_stories.sum(:total_resolved)
      @project.total_canceled = total_stories.sum(:total_canceled)
      @project.total_delays = total_stories.sum(:total_delays)
      @project.total_in_process = total_stories.sum(:total_in_process)
      @project.total_comments = total_stories.sum(:total_comments)
    end
    
    @project.save
    return @project
  end
  
end