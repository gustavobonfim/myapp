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

    squads = ::Users::Works::Trackers::SquadRepository.all_active_by_project(model.id)
    stories = ::Users::Works::Trackers::StoryRepository.all_active_by_project(model.id)

    obj = obj.merge({ "squads" => ::Users::Works::Trackers::SquadRepository.list(squads) })
    obj = obj.merge({ "stories" => ::Users::Works::Trackers::StoryRepository.list(stories) })

    return obj
  end
  

end