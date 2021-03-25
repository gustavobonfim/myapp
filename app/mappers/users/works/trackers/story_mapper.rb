class Users::Works::Trackers::StoryMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "stage_pretty" => ::Users::Works::Trackers::StoryRepository::ENUM_STAGE[model.stage] })
    obj = obj.merge({ "status_pretty" => ::Users::Works::Trackers::StoryRepository::ENUM_STATUS[model.status] })

    return obj
  end

  def self.map_show(model)
    obj = map(model)

    return obj
  end
  
end