class Users::Works::Trackers::Squads::Destroy

  def initialize(params)
    @squad_params = params.require(:squad).permit(:id, :active)
    @current_user_params = params.require(:current_user).permit(:current_user_id)

    # @can_current_user_delete_squad = can_current_user_delete_squad?
    # return false unless @can_current_user_delete_squad

    @squad = squad
    @valid = @squad.valid?
  end

  def squad
    ::Users::Works::Trackers::SquadRepository.find_and_change(@squad_params)
  end
  
  def save
    # return false unless @can_current_user_delete_squad
    ActiveRecord::Base.transaction do
      if @valid 
        @squad.save
        @data = true
        @status = true
        @process = true
        @type = true
        @message = true

        ::Users::Works::Trackers::Projects::UpdateService.new(@squad).update_project
        @squad.destroy

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
    # return cln = [] unless @can_current_user_delete_squad
    if @data
      cln = ::Users::Works::Trackers::SquadRepository.read(@squad)
    else
      cln = []
    end
    
    return {:cln => cln.compact}.as_json
  end

  def status
    # return :forbidden unless @can_current_user_delete_squad
    if @status
      return :ok
    else
      return :bad_request
    end
  end
  
  def type
    # return "danger" unless @can_current_user_delete_squad
    if @type
      return "success"
    else
      return "danger"
    end
  end
  
  def message
    # return message = "A ação não é permitida" unless @can_current_user_delete_squad
    if @message
      message = "Time atualizado com sucesso!"
      return message
    else
      message = "Tivemos seguinte(s) problema(s):"
      i = 0
      @squad.errors.messages.each do |key, value|
        i += 1
        message += " (#{i}) #{value.first}"
      end
      return message
    end
  end

  private

  def can_current_user_delete_squad?
    ::UserPolicies.new(@current_user_params[:current_user_id], "delete", "user_works_trackers_squads").can_current_user?
  end

end
