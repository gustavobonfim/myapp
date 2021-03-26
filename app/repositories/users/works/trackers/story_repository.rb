class Users::Works::Trackers::StoryRepository < Base

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

  def self.all_active_by_project(project_id)
    entity.where(active: true, project_id: project_id).includes(:precedents, :dependents)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.read(story)
    mapper.map(story)
  end
  
  def self.list(stories)
    mapper.map_all(stories)
  end

  def self.list_names(stories)
    mapper.map_all_names(stories)
  end

  private

  def self.entity
    "User::Work::Tracker::Story".constantize
  end

  def self.mapper
    "Users::Works::Trackers::StoryMapper".constantize
  end

  ENUM_STATUS = {
                  "in_progress" => "Em Processo",
                  "frozen" => "Congelado",
                }

  ENUM_STAGE = {
                  "icebox" => "Repositório",
                  "backlog" => "Para Fazer",
                  "current" => "Fazendo",
                  "done" => "Finalizado",
                }

end