class Commercial::Sales::Opportunities::Journeys::Create

  def initialize(params)
    @journey_params = params.require(:journey).permit(:opportunity_id, :stage, :date)
    @product_params = params.require(:product).permit(:stage, :products => [:id, :gain, :lost])
    # @notification_params = params.require(:notification).permit(:domain_id, :domain_type, :date_id, :date_type, :kind, :user_name, :user_id, :action)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    date = Date.parse(@journey_params["date"])
    time = Time.current
    @journey_params = @journey_params.merge({ "date" => Time.new(date.year, date.month, date.day, time.hour, time.min, time.sec) })

    # @can_current_user_create_journey = can_current_user_create_journey?
    # return false unless @can_current_user_create_journey

    @journey = journey

    @valid = @journey.valid?
  end

  def journey
    ::Commercial::Sales::Opportunities::JourneyRepository.build(@journey_params)
  end

  def date
    ::Commercial::Config::DateRepository.find_or_initialize(Date.current)
  end
  
  def save
    # return false unless @can_current_user_create_journey
    ActiveRecord::Base.transaction do
      if @valid 
        @journey.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        if @journey.stage == "gain" || @journey.stage == "lost"
          ::Commercial::Sales::Opportunities::UpdateOpportunityProductsService.new(@product_params[:products]).update_products
        end
        ::Commercial::Sales::Opportunities::UpdateOpportunityService.new(@journey).update_opportunity

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
    # return cln = [] unless @can_current_user_create_journey
    if @data
      cln = ::Commercial::Sales::Opportunities::JourneyRepository.read(@journey)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_journey
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_journey
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_journey
    if @message
      message = "Estágio  atualizado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @journey.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_journey?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "commercial_sales_journeys").can_current_user?
  end

end
