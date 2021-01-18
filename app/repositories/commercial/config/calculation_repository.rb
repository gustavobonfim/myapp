class Commercial::Config::CalculationRepository < Base

  def self.find_and_change(attrs)
    obj = entity.find_by(id: attrs["id"])
    obj[attrs["field"]] = attrs["value"]

    return obj
  end
  

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.read(calculation)
    mapper.map(calculation)
  end
  
  def self.list(calculations)
    mapper.map_all(calculations)
  end
  

  private

  def self.entity
    "Commercial::Config::Calculation".constantize
  end

  def self.mapper
    "Commercial::Config::CalculationMapper".constantize
  end

end