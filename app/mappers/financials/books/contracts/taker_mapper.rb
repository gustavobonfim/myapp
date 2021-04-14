class Financials::Books::Contracts::TakerMapper < BaseMapper

  def self.map(model)    
    obj = model.attributes

    obj = obj.merge({ "id_type_pretty" => Financials::Books::Contracts::TakerRepository::ENUM_TYPE[model.id_type] })

    if model.id_type == "individual"
      obj = obj.merge({ "id_number_pretty" => ::AccountDecorator.cpf_pretty(model.id_number) })
    elsif model.id_type == "legal"
      obj = obj.merge({ "id_number_pretty" => ::CompanyDecorator.cnpj_pretty(model.id_number) })
    end

    return obj
  end

end