class Users::Works::Trackers::Stories::UpdateService

  def initialize(obj)
    @obj = obj

    if @obj.class.name == "User::Work::Tracker::Relation"
      @story_precedent = @obj.precedent
      @story_dependent = @obj.dependent
    elsif @obj.class.name == "User::Work::Activity::Ticket" || @obj.class.name == "User::Work::Activity::Comment"
      @story = Users::Works::Trackers::StoryRepository.find_by_id(@obj.board_id)
    elsif @obj.class.name == "User::Account::Note"
      @story = Users::Works::Trackers::StoryRepository.find_by_id(@obj.domain_id)
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


    elsif @obj.class.name == "User::Work::Activity::Ticket"

      tickets = ::Users::Works::Activities::TicketRepository.all_active_by_board(@obj.board_id, "tracker_stories")

      @story.total_tickets = tickets.count
      @story.total_resolved = tickets.where(stage: "resolved").count
      @story.total_canceled = tickets.where(stage: "canceled").count
      @story.total_in_process = tickets.where(stage: "in_process").count
      @story.total_delays = tickets.where(status: "delay").count
      @story.save

    elsif @obj.class.name == "User::Work::Activity::Comment"

      comments = ::Users::Works::Activities::CommentRepository.all_active_by_board(@obj.board_id, "tracker_stories")

      @story.total_comments = comments.count
      @story.save
    end
    
    ::Users::Works::Trackers::Projects::UpdateService.new(@story).update_project if @story
    return @obj
  end
  
end