class Users::Works::Trackers::ProjectRepository < Base

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

  def self.read(project)
    mapper.map_show(project)
  end
  
  def self.list(projects)
    mapper.map_all(projects)
  end
  

  private

  def self.entity
    "User::Work::Tracker::Project".constantize
  end

  def self.mapper
    "Users::Works::Trackers::ProjectMapper".constantize
  end

  ENUM_UNIT = {
                "develop" => "Tecnologia",
                "marketing" => "Marketing",
                "operation" => "Operação",
                "finance" => "Financeiro",
              }

  ENUM_STATUS = {
                  "frozen" => "Congelado",
                  "in_progress" => "Em Progresso",
                  "canceled" => "Cancelado",
                  "finished" => "Finalizado",
                }

end