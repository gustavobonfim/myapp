class Users::Works::Trackers::Tickets::Update

  def initialize(params)
    @ticket_params = params.require(:ticket).permit(:id, :performer_id, :performer_name, :body, :due_at,
                                                    :stage, :status, :flag, :term, :sharing, :priority, :kind)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_update_ticket = can_current_user_update_ticket?
    # return false unless @can_current_user_update_ticket

    @ticket = ticket
    @valid = @ticket.valid?
  end

  def ticket
    ::Users::Works::Activities::TicketRepository.find_and_change(@ticket_params)
  end
  
  def save
    # return false unless @can_current_user_update_ticket
    ActiveRecord::Base.transaction do
      if @valid 
        @ticket.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        ::Users::Works::Trackers::Stories::UpdateService.new(@ticket).update_story

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
    # return cln = [] unless @can_current_user_update_ticket
    if @data
      cln = ::Users::Works::Activities::TicketRepository.read(@ticket)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_ticket
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_ticket
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_ticket
    if @message
      message = "Ticket criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @ticket.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_update_ticket?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", "user_works_trackers_tickets").can_current_user?
  end

end
