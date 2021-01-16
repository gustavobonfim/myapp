class Commercial::Config::DateRepository < Base

  def self.find_or_initialize(month, year)
    obj = entity.where(month: month, year: year).first

    if obj
      return obj
    else
      return entity.new(month: month, year: year)
    end
  end

  def self.all_active
    objs = entity.where(active: true)

    if objs.empty?
      return [::Commercial::Config::FindOrCreateDateService.new(Date.current).find_or_create_date]
    else
      return objs
    end
  end
  
  def self.list(dates)
    mapper.map_all(dates)
  end
  

  private

  def self.entity
    "Commercial::Config::Date".constantize
  end

  def self.mapper
    "Commercial::Config::DateMapper".constantize
  end

end