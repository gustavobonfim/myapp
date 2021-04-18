class Financials::Books::Contracts::AdditiveRepository < Base

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

  def self.all_active_by_contract(contract_id)
    entity.where(active: true, contract_id: contract_id)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.read(addtive)
    mapper.map(addtive)
  end
  
  def self.list(addtives)
    mapper.map_all(addtives)
  end
  

  private

  def self.entity
    "Financial::Book::Contract::Additive".constantize
  end

  def self.mapper
    "Financials::Books::Contracts::AdditiveMapper".constantize
  end

  ENUM_KIND = {
                "open" => "Aberto",
                "churned" => "Churn",
                "frozen" => "Congelado",
                "discount" => "Desconto",
                "addition" => "Acréscimo",
                "finished" => "Finalizado"
              }

end