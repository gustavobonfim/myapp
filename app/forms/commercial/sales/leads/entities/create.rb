class Commercial::Sales::Leads::Entities::Create

  def initialize(params)
    @source_params = params.require(:source).permit(:source, :source_id, :source_type)
    @lead_params = params.require(:lead).permit(:name, :primary_source, :council_type, :council_number, :council_state, :link, :status)

    # @notification_params = params.require(:notification).permit(:domain_id, :domain_type, :date_id, :date_type, :kind, :user_name, :user_id, :action)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_lead = can_current_user_create_lead?
    # return false unless @can_current_user_create_lead

    if @source_params[:source_type]
      source_class = ::Commercial::Sales::Leads::SourceRepository::SOURCE_TYPE[@source_params[:source_type]]
      source = source_class.constantize.find(@source_params[:source_id])
      @lead_params = @lead_params.merge({ "name" => source.name })
      @lead_params = @lead_params.merge({ "council_type" => "CRM" })
      @lead_params = @lead_params.merge({ "council_number" => source.crm })
      @lead_params = @lead_params.merge({ "council_state" => source.crm_state })
      @source_params = @source_params.merge({ "name" => source.name })
      @source_params = @source_params.merge({ "email" => source.email })
      @source_params = @source_params.merge({ "prefix" => source.ddd })
      @source_params = @source_params.merge({ "phone" => source.number })
    end

    date = ::Commercial::Config::FindOrCreateDateService.new(Date.current).find_or_create_date
    @lead_params = @lead_params.merge({ "date_id" => date.id })
  
    @lead = lead
    @valid = @lead.valid?
  end

  def lead
    ::Commercial::Sales::Leads::EntityRepository.build(@lead_params)
  end

  def date
    ::Commercial::Config::DateRepository.find_or_initialize(Date.current)
  end
  
  def save
    # return false unless @can_current_user_create_lead
    ActiveRecord::Base.transaction do
      if @valid 
        @lead.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        @source_params = @source_params.merge({ "lead_id" => @lead.id })
        @source_params = @source_params.merge({ "council" => @lead.council })
        ::Commercial::Sales::Leads::CreateSourceService.new(@source_params).save_source
        ::Commercial::Config::UpdateCalculationService.new(@lead).update_lead_calculation

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
    # return cln = [] unless @can_current_user_create_lead
    if @data
      cln = ::Commercial::Sales::Leads::EntityRepository.read(@lead)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_lead
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_lead
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_lead
    if @message
      message = "Lead criado com sucesso!"
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

  def can_current_user_create_lead?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "commercial_sales_leads").can_current_user?
  end

end
