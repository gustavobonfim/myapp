class Commercial::Sales::Opportunities::Tickets::List

  def initialize(params)
    @ticket_params = params.require(:ticket).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_ticket = can_current_user_list_ticket?
    # return false unless @can_current_user_list_ticket

    @tickets = tickets
  end

  def tickets
    ::Commercial::Sales::Opportunities::TicketRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_ticket
    @status
  end

  def process?
    # return false unless @can_current_user_list_ticket
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_ticket
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_ticket
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_ticket
    cln = ::Commercial::Sales::Opportunities::TicketRepository.list(@tickets)

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

  def can_current_user_list_ticket?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medbooking_tickets").can_current_user?
  end

end