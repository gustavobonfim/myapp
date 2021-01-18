class Commercial::Sales::Opportunities::Tickets::Create

  def initialize(params)
    @ticket_params = params.require(:ticket).permit(:opportunity_id, :stage, :due_at, :description, :kind, :status)
    # @notification_params = params.require(:notification).permit(:domain_id, :domain_type, :date_id, :date_type, :kind, :user_name, :user_id, :action)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_ticket = can_current_user_create_ticket?
    # return false unless @can_current_user_create_ticket

    @ticket = ticket
    @valid = @ticket.valid?
  end

  def ticket
    ::Commercial::Sales::Opportunities::TicketRepository.build(@ticket_params)
  end

  def date
    ::Commercial::Config::DateRepository.find_or_initialize(Date.current)
  end
  
  def save
    # return false unless @can_current_user_create_ticket
    ActiveRecord::Base.transaction do
      if @valid 
        @ticket.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        ::Commercial::Sales::Opportunities::UpdateOpportunityService.new(@ticket).update_opportunity

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
    # return cln = [] unless @can_current_user_create_ticket
    if @data
      cln = ::Commercial::Sales::Opportunities::TicketRepository.read(@ticket)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_ticket
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_ticket
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_ticket
    if @message
      message = "Produto adicionado com sucesso!"
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

  def can_current_user_create_ticket?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "commercial_sales_tickets").can_current_user?
  end

end
