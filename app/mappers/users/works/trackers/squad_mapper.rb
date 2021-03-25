class Users::Works::Trackers::SquadMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "role_pretty" => ::Users::Works::Trackers::SquadRepository::ENUM_ROLE[model.role] })

    return obj
  end

  def self.map_show(model)
    obj = map(model)

    return obj
  end
  

end