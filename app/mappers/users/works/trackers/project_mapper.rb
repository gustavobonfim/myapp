class Users::Works::Trackers::ProjectMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "started_at_pretty" => model.started_at })
    obj = obj.merge({ "unit_pretty" => ::Users::Works::Trackers::ProjectRepository::ENUM_UNIT[model.unit] })
    obj = obj.merge({ "status_pretty" => ::Users::Works::Trackers::ProjectRepository::ENUM_STATUS[model.status] })

    return obj
  end

  def self.map_show(model)
    obj = map(model)

    obj = obj.merge({ "squads" => ::Users::Works::Trackers::SquadRepository.list(model.squads) })

    return obj
  end
  

end