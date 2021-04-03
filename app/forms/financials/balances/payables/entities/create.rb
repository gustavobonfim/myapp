class Financials::Balances::Payables::Entities::Create

  def initialize(params)
    @payable_params = params.require(:payable).permit(:chart_id, :med_id, :channel_id, :provider_id, :provider_name,
                                                      :due_date, :accrual_date, :amount, :description, :chart_account,
                                                      :chart_name, :method, :channel_name, :bank_line, :recurring, :splited,
                                                      :split, :installment)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_payable = can_current_user_create_payable?
    # return false unless @can_current_user_create_payable    
    
    date = ::Financials::Config::FindOrCreateDateService.new(Date.current).find_or_create_date
    @payable_params = @payable_params.merge({ "date_id" => date.id })
  
    @payable = payable
    @valid = @payable.valid?
  end

  def payable
    ::Financials::Balances::Payables::EntityRepository.build(@payable_params)
  end

  # def date
  #   ::Commercial::Config::DateRepository.find_or_initialize(Date.current)
  # end
  
  def save
    # return false unless @can_current_user_create_payable
    ActiveRecord::Base.transaction do
      if @valid
        # @payable.save
        
        ::Commercial::Config::UpdateCalculationService.new(@payable).update_payable_calculation

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
    # return cln = [] unless @can_current_user_create_payable
    if @data
      cln = ::Financials::Balances::Payables::EntityRepository.read(@payable)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_payable
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_payable
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_payable
    if @message
      message = "Fornecedor criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @payable.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_payable?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "financial_payable_entities").can_current_user?
  end

end
