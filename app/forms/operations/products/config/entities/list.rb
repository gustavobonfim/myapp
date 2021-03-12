class Operations::Products::Config::Entities::List

  def initialize(params)
    @mode_params = params.require(:mode).permit(:mode)
    @account_params = params.require(:account).permit(:account_id)
    @product_params = params.require(:product).permit(:name, :kind)
    @current_user_params = params.require(:current_user).permit(:current_user_id, :permissions)

    # @can_current_user_list_product = can_current_user_list_product?
    # return false unless @can_current_user_list_product

    @products = products
  end

  def products
    
    if @mode_params[:mode] == "account"
      @products ||= ::Operations::Products::Config::EntityRepository.all_active_by_account_and_name(@account_params[:account_id], @product_params[:name])
    elsif @mode_params[:mode] == "product"
      @products ||= ::Operations::Products::Config::EntityRepository.all_active_by_name_and_kind(@product_params[:name], @product_params[:kind])
    end
    
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
    cln = ::Operations::Products::Config::EntityRepository.list(@products)

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