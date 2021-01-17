class Commercial::Sales::Opportunities::Leads::Update

  def initialize(params)
    @lead_params = params.require(:lead).permit(:id, :active)
    # @notification_params = params.require(:notification).permit(:domain_id, :domain_type, :date_id, :date_type, :kind, :user_name, :user_id, :action)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_update_lead = can_current_user_update_lead?
    # return false unless @can_current_user_update_lead

    @lead = lead
    @valid = @lead.valid?
  end

  def lead
    ::Commercial::Sales::Opportunities::LeadRepository.find_and_change(@lead_params)
  end

  def date
    ::Commercial::Config::DateRepository.find_or_initialize(Date.current)
  end
  
  def save
    # return false unless @can_current_user_update_lead
    ActiveRecord::Base.transaction do
      if @valid 
        @lead.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        ::Commercial::Sales::Opportunities::UpdateOpportunityService.new(@lead.opportunity).update_opportunity

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
    # return cln = [] unless @can_current_user_update_lead
    if @data
      cln = ::Commercial::Sales::Opportunities::LeadRepository.read(@lead)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_lead
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_lead
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_lead
    if @message
      message = "Produto retirado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @lead.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_update_lead?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", "commercial_sales_leads").can_current_user?
  end

end
