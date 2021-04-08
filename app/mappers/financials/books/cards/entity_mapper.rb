class Financials::Books::Cards::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes
    med = model.med

    obj = obj.merge({ "med_name" => med.name })

    return obj
  end

end