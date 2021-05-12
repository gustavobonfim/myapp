class Operations::Onboards::DateRepository < Base

  def self.find_or_initialize(month, year)
    obj = entity.where(month: month, year: year).first

    if obj
      return obj
    else
      return entity.new(month: month, year: year)
    end
  end

  def self.all_active
    objs = entity.where(active: true).order(token: :desc)

    if objs.empty?
      return [::Operations::Onboards::FindOrCreateDateService.new(Date.current).find_or_create_date]
    else
      return objs
    end
  end

  def self.find_by_token(token)
    objs = entity.where(active: true, token: token)

    if objs.empty?
      return [::Operations::Onboards::FindOrCreateDateService.new(Date.current).find_or_create_date]
    else
      return objs
    end
  end

  def self.read(date)
    mapper.map(date)
  end
  
  def self.list(dates)
    mapper.map_all(dates)
  end
  

  private

  def self.entity
    "Operation::Onboard::Date".constantize
  end

  def self.mapper
    "Operations::Onboards::DateMapper".constantize
  end

end