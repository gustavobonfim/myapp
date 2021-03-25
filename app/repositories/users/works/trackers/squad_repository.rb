class Users::Works::Trackers::SquadRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    
    return obj
  end

  def self.find_and_change(attrs)
    obj = entity.find_by(id: attrs["id"])
    obj.attributes = attrs

    return obj
  end

  def self.all_active
    entity.where(active: true)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.read(squad)
    mapper.map(squad)
  end
  
  def self.list(squads)
    mapper.map_all(squads)
  end
  

  private

  def self.entity
    "User::Work::Tracker::Squad".constantize
  end

  def self.mapper
    "Users::Works::Trackers::SquadMapper".constantize
  end

  ENUM_UNIT = {
                "owner" => "Proprietário",
                "editor" => "Editor",
                "viewer" => "Visitante",
              }


end