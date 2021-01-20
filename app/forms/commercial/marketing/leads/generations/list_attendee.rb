class Commercial::Marketing::Leads::Generations::ListAttendee

  def initialize(params)
    @attendee_params = params.require(:attendee).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_attendee = can_current_user_list_attendee?
    # return false unless @can_current_user_list_attendee

    @attendees = attendees
  end

  def attendees
    ::Commercial::Marketing::Events::AttendeeRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_attendee
    @status
  end

  def process?
    # return false unless @can_current_user_list_attendee
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_attendee
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_attendee
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_attendee
    cln = ::Commercial::Marketing::Events::AttendeeRepository.lead_gen(@attendees)

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

  def can_current_user_list_attendee?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medbooking_attendees").can_current_user?
  end

end