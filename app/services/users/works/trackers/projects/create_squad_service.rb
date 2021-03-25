class Users::Works::Trackers::Projects::CreateSquadService

  def initialize(attrs)
    @attrs = attrs
  end

  def create_squad
    squad = ::Users::Works::Trackers::SquadRepository.build(@attrs)

    if squad.valid?
      squad.save
    else
      raise ActiveRecord::Rollback
    end
    
    return squad
  end
  
end