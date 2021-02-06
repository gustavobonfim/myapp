class Users::Companies::Entities::Read

  def initialize(params)
    @company_params = params.require(:company).permit(:id, :token)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_read_company = can_current_user_read_company?
    # return false unless @can_current_user_read_company

    @company = company
  end

  def company
    if @company_params[:cnpj].present?
      ::Users::Companies::EntityRepository.find_by_cnpj_or_initialize_by_cnpj_and_kind(@company_params[:cnpj], @company_params[:kind])
    elsif @company_params[:id].present?
      ::Users::Companies::EntityRepository.find_by_id(@company_params[:id])
    end
  end

  def status
    # return :forbidden unless @can_current_user_read_company
    @status
  end

  def process?
    # return false unless @can_current_user_read_company
    @process
  end

  def type
    # return "danger" unless @can_current_user_read_company
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_read_company
    @message
  end

  def data
    # return cln = [] unless @can_current_user_read_company
    cln = ::Users::Companies::EntityRepository.read(@company)

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

  def can_current_user_read_company?
    ::UserPolicies.new(@current_user_params[:current_user_id], "read", "medbooking_company").can_current_user?
  end

end