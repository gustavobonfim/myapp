class Commercial::Config::Calculations::Update

  def initialize(params)
    @calculation_params = params.require(:calculation).permit(:id, :value, :field)
    # @notification_params = params.require(:notification).permit(:domain_id, :domain_type, :date_id, :date_type, :kind, :user_name, :user_id, :action)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_update_calculation = can_current_user_update_calculation?
    # return false unless @can_current_user_update_calculation

    @calculation = calculation
    @valid = @calculation.valid?
  end

  def calculation
    ::Commercial::Config::CalculationRepository.find_and_change(@calculation_params)
  end
  
  def save
    # return false unless @can_current_user_update_calculation
    ActiveRecord::Base.transaction do
      if @valid 
        @calculation.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

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
    # return cln = [] unless @can_current_user_update_calculation
    if @data
      cln = ::Commercial::Config::CalculationRepository.read(@calculation)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_calculation
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_calculation
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_calculation
    if @message
      message = "Produto adicionado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @calculation.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_update_calculation?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", "commercial_sales_calculations").can_current_user?
  end

end
