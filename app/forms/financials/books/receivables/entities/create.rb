class Financials::Books::Receivables::Entities::Create

  def initialize(params)
    @receivable_params = params.require(:receivable).permit(:id)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_receivable = can_current_user_create_receivable?
    # return false unless @can_current_user_create_receivable    
    
    date = ::Financials::Config::FindOrCreateDateService.new(@receivable_params[:due_date]).find_or_create_date
    @receivable_params = @receivable_params.merge({ "date_id" => date.id })
  
    @receivable = receivable
    @valid = @receivable.valid?
  end

  def receivable
    ::Financials::Books::Receivables::EntityRepository.build(@receivable_params)
  end

  # def date
  #   ::Commercial::Config::DateRepository.find_or_initialize(Date.current)
  # end
  
  def save
    # return false unless @can_current_user_create_receivable
    ActiveRecord::Base.transaction do
      if @valid
        @receivable.save

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
    # return cln = [] unless @can_current_user_create_receivable
    if @data
      cln = ::Financials::Books::Receivables::EntityRepository.read(@receivable)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_receivable
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_receivable
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_receivable
    if @message
      message = "Recebível criado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @receivable.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_create_receivable?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "financial_receivable_entities").can_current_user?
  end

end
