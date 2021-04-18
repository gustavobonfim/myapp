class Financials::Books::Contracts::EntityRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    obj.token = set_token("token").upcase
    
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

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.read(contract)
    mapper.map(contract)
  end
  
  def self.list(contracts)
    mapper.map_all(contracts)
  end
  

  private

  def self.entity
    "Financial::Book::Contract::Entity".constantize
  end

  def self.mapper
    "Financials::Books::Contracts::EntityMapper".constantize
  end

  def self.set_token(field)
    token = Base.generate_token
    set_token if valid_field(field, token)
    token
  end

  ENUM_KIND = {
                  "setup" => "Setup",
                  "recurring" => "Recorrente"
                }

  ENUM_STATUS = {
                  "open" => "Aberto",
                  "churned" => "Churn",
                  "frozen" => "Congelado",
                  "finished" => "Finalizado"
                }

  ENUM_PLAN = {
                  "monthly" => "Mensal",
                  "yearly" => "Anual"
                }

  ENUM_PRODUCT_NAME = {
                        "medreturn" => "Planner",
                        "medfiling" => "Declaração IRPF",
                        "medbooking" => "Livro-Caixa",
                        "medclinic" => "PJ Médica",
                        "medreceivement" => "Gestão de Recebimentos",
                        "medfat" => "Faturamento",
                        "medpayroll" => "Folha de Pagamento",
                        "medconsulting" => "Consultoria",
                      }

  ENUM_PRODUCT_KIND = {
                        "receivement" => "Recebimento",
                        "practice" => "Consultório",
                        "none" => "Nenhum",
                      }

  ENUM_PRODUCT_SERVICE = {
                        "opening" => "Abertura",
                        "pos_opening" => "Pós-Abertura",
                        "migration" => "Migração",
                        "amendment" => "Alteração",
                        "regularization" => "Regularização",
                        "separate" => "Avulso",
                      }

end