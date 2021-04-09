class Financials::Books::Cards::Bills::UpdatePaid

  def initialize(params)
    @bill_params = params.require(:bill).permit(:id, :paid)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_update_bill = can_current_user_update_bill?
    # return false unless @can_current_user_update_bill
  
    @bill = bill
    @valid = @bill.valid?
  end

  def bill
    ::Financials::Books::Cards::BillRepository.find_and_change(@bill_params)
  end

  # def date
  #   ::Commercial::Config::DateRepository.find_or_initialize(Date.current)
  # end
  
  def save
    # return false unless @can_current_user_update_bill
    ActiveRecord::Base.transaction do
      if @valid
        @bill.save
      
        # ::Financials::Books::Cards::UpdatePaidPayableTransactionService.new(@bill) if @bill.paid

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
    # return cln = [] unless @can_current_user_update_bill
    if @data
      cln = ::Financials::Books::Cards::BillRepository.read(@bill)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_bill
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_bill
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_bill
    if @message
      message = "Pagamento atualizado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @bill.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_update_bill?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", "financial_card_bills").can_current_user?
  end

end
