class Users::Works::Trackers::RelationRepository < Base

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

  def self.all_active_precedents(precedent_id)
    entity.where(active: true, precedent_id: precedent_id)
  end

  def self.all_active_dependents(dependent_id)
    entity.where(active: true, dependent_id: dependent_id)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.read(relation)
    mapper.map(relation)
  end
  
  def self.list(relations)
    mapper.map_all(relations)
  end
  

  private

  def self.entity
    "User::Work::Tracker::Relation".constantize
  end

  def self.mapper
    "Users::Works::Trackers::RelationMapper".constantize
  end

end