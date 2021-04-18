class Financials::Books::Transactions::Entities::Destroy

  def initialize(params)
    @transaction_params = params.require(:transaction).permit(:id, :active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_delete_transaction = can_current_user_delete_transaction?
    # return false unless @can_current_user_delete_transaction    
  
    @transaction = transaction
    @valid = @transaction.valid?
  end

  def transaction
    ::Financials::Books::Transactions::EntityRepository.find_and_change(@transaction_params)
  end
  
  def save
    # return false unless @can_current_user_delete_transaction
    ActiveRecord::Base.transaction do
      
      if @valid
        ::Financials::Books::Statements::DestroyInternTransactionService.new(@transaction)

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
    # return cln = [] unless @can_current_user_delete_transaction
    if @data
      cln = ::Financials::Books::Transactions::EntityRepository.read(@transaction)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_delete_transaction
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_delete_transaction
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_delete_transaction
    if @message
      message = "Transação apagada com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @transaction.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_delete_transaction?
    ::UserPolicies.new(@current_user_params[:current_user_id], "delete", "financial_transaction_entities").can_current_user?
  end

end
