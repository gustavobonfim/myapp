class Commercial::Config::DateMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "calculation" => model.calculation })

    return obj
  end

end