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

  def self.map_names(model)
    obj = {}

    obj = obj.merge({ "story_id" => model.id })
    obj = obj.merge({ "story_name" => "#{model.project.name} | #{model.name}" })

    return obj
  end
  
  def self.map_all_names(obj_collection)
    obj_collection.map{ |obj| map_names(obj) }
  end
  
end