class Commercial::Sales::Opportunities::Entities::Create

  def initialize(params)
    @opportunity_params = params.require(:opportunity).permit(:status, :source, :started_at)
    @lead_params = params.require(:lead).permit(:lead_id)
    # @notification_params = params.require(:notification).permit(:domain_id, :domain_type, :date_id, :date_type, :kind, :user_name, :user_id, :action)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_opportunity = can_current_user_create_opportunity?
    # return false unless @can_current_user_create_opportunity

    date = ::Commercial::Config::FindOrCreateDateService.new(@opportunity_params[:started_at]).find_or_create_date
    @opportunity_params = @opportunity_params.merge({ "date_id" => date.id })

    @opportunity = opportunity
    @valid = @opportunity.valid?
  end

  def opportunity
    ::Commercial::Sales::Opportunities::EntityRepository.build(@opportunity_params)
  end

  def date
    ::Commercial::Config::DateRepository.find_or_initialize(Date.current)
  end
  
  def save
    # return false unless @can_current_user_create_opportunity
    ActiveRecord::Base.transaction do
      if @valid 
        @opportunity.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        ::Commercial::Sales::Opportunities::CreateOpportunityLeadService.new(@opportunity.date_id, @opportunity.id, @lead_params[:lead_id]).save_lead
        ::Commercial::Sales::Opportunities::CreateOpportunityJourneyService.new(@opportunity).save_journey

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
    # return cln = [] unless @can_current_user_create_opportunity
    if @data
      cln = ::Commercial::Sales::Opportunities::EntityRepository.read(@opportunity)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_opportunity
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_opportunity
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_opportunity
    if @message
      message = "Oportunidade criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @opportunity.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_opportunity?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "commercial_sales_opportunitys").can_current_user?
  end

end
