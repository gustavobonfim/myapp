class Commercial::Sales::Opportunities::Products::List

  def initialize(params)
    @product_params = params.require(:product).permit(:active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_product = can_current_user_list_product?
    # return false unless @can_current_user_list_product

    @products = products
  end

  def products
    ::Commercial::Sales::Opportunities::ProductRepository.all_active
  end

  def status
    # return :forbidden unless @can_current_user_list_product
    @status
  end

  def process?
    # return false unless @can_current_user_list_product
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_product
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_product
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_product
    cln = ::Commercial::Sales::Opportunities::ProductRepository.list(@products)

    if cln.empty?
      @status = :ok
      @process = false
      @message = ""
      @type = "danger"
    else
      @status = :ok
      @process = true
      @message = ""
      @type = "success"
    end
    
    return {:cln => cln.compact}.as_json
  end

  private

  def can_current_user_list_product?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medbooking_products").can_current_user?
  end

end