class Users::Works::Trackers::Relations::Destroy

  def initialize(params)
    @relation_params = params.require(:relation).permit(:id, :active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_delete_relation = can_current_user_delete_relation?
    # return false unless @can_current_user_delete_relation

    @relation = relation
    @valid = @relation.valid?
  end

  def relation
    ::Users::Works::Trackers::RelationRepository.find_and_change(@relation_params)
  end
  
  def save
    # return false unless @can_current_user_delete_relation
    ActiveRecord::Base.transaction do
      if @valid 
        @relation.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        ::Users::Works::Trackers::Stories::UpdateService.new(@relation).update_story
        @relation.destroy

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
    # return cln = [] unless @can_current_user_delete_relation
    if @data
      cln = ::Users::Works::Trackers::RelationRepository.read(@relation)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_delete_relation
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_delete_relation
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_delete_relation
    if @message
      message = "Relação apagada com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @relation.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_delete_relation?
    ::UserPolicies.new(@current_user_params[:current_user_id], "delete", "user_works_trackers_relations").can_current_user?
  end

end
