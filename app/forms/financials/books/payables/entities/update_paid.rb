class Financials::Books::Payables::Entities::UpdatePaid

  def initialize(params)
    @payable_params = params.require(:payable).permit(:id, :paid)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_update_payable = can_current_user_update_payable?
    # return false unless @can_current_user_update_payable
  
    @payable = payable
    @valid = @payable.valid?
  end

  def payable
    ::Financials::Books::Payables::EntityRepository.find_and_change(@payable_params)
  end

  # def date
  #   ::Commercial::Config::DateRepository.find_or_initialize(Date.current)
  # end
  
  def save
    # return false unless @can_current_user_update_payable
    ActiveRecord::Base.transaction do
      if @valid
        @payable.save
      
        ::Financials::Books::Payables::UpdatePaidPayableTransactionService.new(@payable) if @payable.paid

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
    # return cln = [] unless @can_current_user_update_payable
    if @data
      cln = ::Financials::Books::Payables::EntityRepository.read(@payable)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_payable
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_payable
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_payable
    if @message
      message = "Pagamento atualizado com sucesso!"
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

  def can_current_user_update_payable?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", "financial_payable_entities").can_current_user?
  end

end
