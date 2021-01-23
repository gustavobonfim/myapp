class Commercial::Sales::Opportunities::Products::Update

  def initialize(params)
    @product_params = params.require(:product).permit(:id, :active, :gain, :lost)
    # @notification_params = params.require(:notification).permit(:domain_id, :domain_type, :date_id, :date_type, :kind, :user_name, :user_id, :action)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_update_product = can_current_user_update_product?
    # return false unless @can_current_user_update_product

    @product = product
    @valid = @product.valid?
  end

  def product
    ::Commercial::Sales::Opportunities::ProductRepository.find_and_change(@product_params)
  end

  def date
    ::Commercial::Config::DateRepository.find_or_initialize(Date.current)
  end
  
  def save
    # return false unless @can_current_user_update_product
    ActiveRecord::Base.transaction do
      if @valid 
        @product.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        ::Commercial::Sales::Opportunities::UpdateOpportunityService.new(@product).update_opportunity

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
    # return cln = [] unless @can_current_user_update_product
    if @data
      cln = ::Commercial::Sales::Opportunities::ProductRepository.read(@product)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_update_product
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_update_product
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_update_product
    if @message
      message = "Produto retirado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @product.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_update_product?
    ::UserPolicies.new(@current_user_params[:current_user_id], "update", "commercial_sales_products").can_current_user?
  end

end
