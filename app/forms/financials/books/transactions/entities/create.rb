class Financials::Books::Transactions::Entities::Create

  def initialize(params)
    @transaction_params = params.require(:transaction).permit(:med_id, :channel_id, :from_id, :to_id, :from_master_name,
                                                              :from_group, :from_master_group, :from_master, :to_master_name,
                                                              :to_group, :to_master_group, :to_master, :amount, :from_amount,
                                                              :to_amount, :date, :description, :method, :channel_name,
                                                              :recurring, :kind, :source)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_transaction = can_current_user_create_transaction?
    # return false unless @can_current_user_create_transaction    
    
    date = ::Financials::Config::FindOrCreateDateService.new(@transaction_params[:date]).find_or_create_date
    @transaction_params = @transaction_params.merge({ "date_id" => date.id })
  
    @transaction = transaction
    @date = date
    @valid = @transaction.valid?
  end

  def transaction
    ::Financials::Books::Transactions::EntityRepository.build(@transaction_params)
  end
  
  def save
    # return false unless @can_current_user_create_transaction
    ActiveRecord::Base.transaction do
      
      if @valid
        @transaction.token_tree = ::Financials::Books::Transactions::EntityRepository.set_token("token_tree").upcase

        @transaction.save
        ::Financials::Books::Balances::UpdateBalancesService.new(@transaction)
        ::Financials::Books::Statements::CreateProfitTransactionService.new(@transaction) if @transaction.kind == "statement"

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
    # return cln = [] unless @can_current_user_create_transaction
    if @data
      cln = ::Financials::Books::Transactions::EntityRepository.read(@transaction)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_transaction
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_transaction
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_transaction
    if @message
      message = "Transação Isolada criada com sucesso!"
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

  def can_current_user_create_transaction?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "financial_transaction_entities").can_current_user?
  end

end
