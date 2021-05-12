class Operations::Onboards::EntityRepository < Base

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
    entity.where(active: true).includes(:chart)
  end

  def self.all_active_by_date(date_id)
    entity.where(active: true, date_id: date_id).includes(:chart)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.read(balance)
    mapper.map(balance)
  end
  
  def self.list(balances)
    mapper.map_all(balances)
  end
  

  private

  def self.entity
    "Operation::Onboard::Entity".constantize
  end

  def self.mapper
    "Operations::Onboards::EntityMapper".constantize
  end

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
                        "home" => "e-Social",
                        "employee" => "Funcionário",
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

  ENUM_KIND = {
                "setup" => "Setup",
                "recurring" => "Recorrente"
              }

  ENUM_STATUS = {
                  "going" => "Em Processo",
                  "finished" => "Finalizado",
                  "cancel" => "Cancelado"
                }

end