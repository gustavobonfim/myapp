class Financials::Config::DateRepository < Base

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
      return [::Financials::Config::FindOrCreateDateService.new(Date.current).find_or_create_date]
    else

      objs.each do |date|
        if date != objs[0]
          date.open = false
          date.save
        end
      end

      return objs
    end
  end

  def self.find_by_token(token)
    objs = entity.where(active: true, token: token)

    if objs.empty?
      return [::Financials::Config::FindOrCreateDateService.new(Date.current).find_or_create_date]
    else
      return objs
    end
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.read(date)
    mapper.map(date)
  end
  
  def self.list(dates)
    mapper.map_all(dates)
  end
  

  private

  def self.entity
    "Financial::Config::Date".constantize
  end

  def self.mapper
    "Financials::Config::DateMapper".constantize
  end

end