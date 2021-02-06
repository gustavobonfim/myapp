class Users::Companies::Entities::List

  def initialize(params)
    @company_params = params.require(:company).permit(:active, :kind, :subkind)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_list_company = can_current_user_list_company?
    # return false unless @can_current_user_list_company

    @companies = companies
  end

  def companies
    if @company_params[:subkind].presence.nil?
      @companies ||= ::Users::Companies::EntityRepository.all_active_by_kind(@company_params[:kind])
    elsif @company_params[:subkind].presence.present?
      @companies ||= ::Users::Companies::EntityRepository.all_active_by_subkind(@company_params[:subkind])
    end
  end

  def status
    # return :forbidden unless @can_current_user_list_company
    @status
  end

  def process?
    # return false unless @can_current_user_list_company
    @process
  end

  def type
    # return "danger" unless @can_current_user_list_company
    @type
  end

  def message
    # return message = "A ação não é permitida" unless @can_current_user_list_company
    @message
  end

  def data
    # return cln = [] unless @can_current_user_list_company
    cln = ::Users::Companies::EntityRepository.list(@companies)

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

  def can_current_user_list_company?
    ::UserPolicies.new(@current_user_params[:current_user_id], "list", "medbooking_companies").can_current_user?
  end

end