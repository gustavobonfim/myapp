class Financials::Books::Balances::Entities::Create

  def initialize(params)
    @balance_params = params.require(:balance).permit(:date_id, :date)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_balance = can_current_user_create_balance?
    # return false unless @can_current_user_create_balance

    @date = ::Financials::Config::FindOrCreateDateService.new(@balance_params[:date]).find_or_create_date
    @valid = @date.valid?
  end

  def date
    ::Financials::Config::DateRepository.find_by_id(@balance_params[:date_id])
  end

  def balances
    ::Financials::Books::Balances::EntityRepository.all_active_by_date(@date.id)
  end

  def status
    # return :forbidden unless @can_current_user_create_balance
    @status
  end

  def process?
    # return false unless @can_current_user_create_balance
    @process
  end

  def type
    # return "danger" unless @can_current_user_create_balance
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_balance
    @message
  end

  def save
    # return false unless @can_current_user_create_payable
    ActiveRecord::Base.transaction do
      if @valid
        
        ::Financials::Books::Balances::CreateBalancesService.new(@date)

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
      @balances = balances

      cln = ::Financials::Books::Balances::EntityRepository.list(@balances)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  private

  def can_current_user_create_balance?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "financial_balance_entities").can_current_user?
  end

end