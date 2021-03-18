class Users::Works::Trackers::ProjectMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "unit_pretty" => ::Users::Works::Trackers::ProjectRepository::ENUM_UNIT[model.unit] })
    obj = obj.merge({ "status_pretty" => ::Users::Works::Trackers::ProjectRepository::ENUM_STATUS[model.status] })

    return obj
  end

end