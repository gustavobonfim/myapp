class Commercial::Sales::Opportunities::ProductRepository < Base

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
    entity.where(active: true).order(name: :asc)
  end

  def self.all_active_by_opportunity(opportunity_id)
    entity.where(active: true, opportunity_id: opportunity_id).order(name: :asc)
  end

  def self.read(product)
    mapper.map(product)
  end
  
  def self.list(products)
    mapper.map_all(products)
  end
  

  private

  def self.entity
    "Commercial::Sale::Opportunity::Product".constantize
  end

  def self.mapper
    "Commercial::Sales::Opportunities::ProductMapper".constantize
  end

  ENUM_NAME = {
                "medclinic" => "PJ Médica",
                "medpf" => "",
                "medreceivement" => "Gestão de Recebimento",
                "medseg" => "Seguros",
                "medfin" => "",
                "medreturn" => "Planner",
                "medbooking" => "Livro-Caixa",
                "medfiling" => "Declaração IRPF",
              }


  ENUM_KIND = {
                "receivement" => "Recebimento",
                "practice" => "Consultório",
              }
end