class Operations::Onboards::DateMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    # obj = obj.merge({ "calculation" => ::Operations::Onboards::CalculationRepository.read(model.calculation) })

    return obj
  end

end