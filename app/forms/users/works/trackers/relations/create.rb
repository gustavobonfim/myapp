class Users::Works::Trackers::Relations::Create

  def initialize(params)
    @relation_params = params.require(:relation).permit(:dependent_id, :precedent_id, :name, :dependent_slug, :precedent_slug)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_create_relation = can_current_user_create_relation?
    # return false unless @can_current_user_create_relation

    @relation = relation
    @valid = @relation.valid?
  end

  def relation
    ::Users::Works::Trackers::RelationRepository.build(@relation_params)
  end
  
  def save
    # return false unless @can_current_user_create_relation
    ActiveRecord::Base.transaction do
      if @valid 
        @relation.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        ::Users::Works::Trackers::Stories::UpdateService.new(@relation).update_story

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
    # return cln = [] unless @can_current_user_create_relation
    if @data
      cln = ::Users::Works::Trackers::RelationRepository.read(@relation)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_create_relation
    if @status
      return :created
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_create_relation
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_create_relation
    if @message
      message = "Relação criada com sucesso!"
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

  def can_current_user_create_relation?
    ::UserPolicies.new(@current_user_params[:current_user_id], "create", "user_works_trackers_relations").can_current_user?
  end

end
