class Financials::Books::Settings::ChartAccountRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    obj.token = "#{NUM_MASTER[attrs["master"]]}.#{NUM_MASTER_GROUP[attrs["master_group"]]}.#{NUM_GROUP[attrs["group"]]}.#{NUM_MASTER_NAME[attrs["master_name"]]}.#{attrs["code"]}"
    obj.chart_account = "#{NUM_MASTER[attrs["master"]]}.#{NUM_MASTER_GROUP[attrs["master_group"]]}.#{NUM_GROUP[attrs["group"]]}.#{NUM_MASTER_NAME[attrs["master_name"]]}.#{attrs["code"]} - #{ENUM_MASTER_NAME[attrs["master_name"]]} | #{attrs["name"]}"
    obj.chart_name = "#{ENUM_MASTER_NAME[attrs["master_name"]]} | #{attrs["name"]}"
    
    return obj
  end

  def self.find_and_change(attrs)
    obj = entity.find_by(id: attrs["id"])
    obj.attributes = attrs
    obj.chart_account = "#{NUM_MASTER[attrs["master"]]}.#{NUM_MASTER_GROUP[attrs["master_group"]]}.#{NUM_GROUP[attrs["group"]]}.#{NUM_MASTER_NAME[attrs["master_name"]]}.#{attrs["code"]} - #{ENUM_MASTER_NAME[attrs["master_name"]]} | #{attrs["name"]}"
    obj.chart_name = "#{ENUM_MASTER_NAME[attrs["master_name"]]} | #{attrs["name"]}"

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

  def self.find_by_name(name)
    entity.find_by(name: name)
  end

  def self.find_by_master_name(master_name)
    entity.find_by(master_name: master_name)
  end

  def self.read(chart_account)
    mapper.map(chart_account)
  end
  
  def self.list(chart_accounts)
    mapper.map_all(chart_accounts)
  end
  

  private

  def self.entity
    "Financial::Book::Setting::ChartAccount".constantize
  end

  def self.mapper
    "Financials::Books::Settings::ChartAccountMapper".constantize
  end

  ENUM_KIND = {
                "statement" => "Resultado",
                "balance" => "Patrimonial",
              }

  ENUM_MASTER_NAME = {
                        "availabilities" => "Disponibilidades",
                        "short_term_financial_investments" => "Aplicações Financeiras de Curto Prazo",
                        "clients" => "Clientes",
                        "miscellaneous_credits" => "Créditos Diversos",
                        "prepaid_signatures" => "Antecipação Assinaturas",
                        "prepaid_office" => "Antecipação Escritório",
                        "prepaid_outsourcing" => "Antecipação Serviços Terceiros",
                        "prepaid_people" => "Antecipação Pessoal",
                        "prepaid_miscellaneuos" => "Antecipação Outras",
                        "taxes_to_be_recovered" => "Impostos a Recuperar",
                        "contribuition_and_others_to_be_recovered" => "Contribuições e Outros a Recuperar",
                        "receivable_loan" => "Mútuos a Receber",
                        "fixed_assets" => "Ativos Permanentes",
                        "long_term_financial_investments" => "Aplicações Financeiras de Longo Prazo",
                        "branding_know_how" => "Marcas e Know-how",
                        "people_payables" => "Pessoas a Pagar",
                        "expense_payables" => "Despesas a Pagar",
                        "people_technology" => "Pessoal Tecnologia",
                        "infrastructure_technology" => "Infraestrutura Tecnologia",
                        "production_technology" => "Produção Tecnologia",
                        "profit_and_loss" => "Lucro/Prejuízo",
                        "master_name_result" => "Resultado",
                      }

  ENUM_GROUP = {
                 "cash_and_cash_equivalents" => "Disponibilidades e Equivalentes",
                 "receivables" => "Contas a Receber",
                 "prepaid_expenses" => "Despesas Antecipadas",
                 "taxes_and_contributions_to_be_recovered" => "Impostos e Contribuições a Recuperar",
                 "group_loans" => "Mútuos no Grupo",
                 "tangible" => "Tangível",
                 "intagible" => "Intangível",
                 "payables" => "Contas a Pagar",
                 "accrued_profit_and_loss" => "Lucro/Prejuízo Acumulado",
                 "people_expenses" => "Despesas com Pessoal",
                 "technology_expenses" => "Despesas com Tecnologia",
                 "group_result" => "Resultado",
               }

  ENUM_MASTER_GROUP = {
                        "current" => "Circulante",
                        "not_current" => "Não-Circulante",
                        "net_equity" => "Patrimônio Líquido",
                        "operating_revenues" => "Receitas Operacionais",
                        "non_operating_revenues" => "Receitas Não-Operacionais",
                        "operating_expenses" => "Despesas Operacionais",
                        "non_operating_expenses" => "Despesas Não-Operacionais",
                        "master_group_result" => "Resultado",
                      }

  ENUM_MASTER = {
                  "asset" => "Ativo",
                  "liability" => "Passivo",
                  "revenues" => "Receitas",
                  "expenses" => "Despesas",
                  "result" => "Resultado",
                  "taxes" => "Impostos",
                }

  NUM_MASTER_NAME = {
                      "availabilities" => "01",
                      "short_term_financial_investments" => "02",
                      "clients" => "01",
                      "miscellaneous_credits" => "01",
                      "prepaid_signatures" => "01",
                      "prepaid_office" => "02",
                      "prepaid_outsourcing" => "03",
                      "prepaid_people" => "04",
                      "prepaid_miscellaneuos" => "05",
                      "taxes_to_be_recovered" => "01",
                      "contribuition_and_others_to_be_recovered" => "02",
                      "receivable_loan" => "01",
                      "fixed_assets" => "01",
                      "long_term_financial_investments" => "02",
                      "branding_know_how" => "01",
                      "people_payables" => "01",
                      "expense_payables" => "02",
                      "people_technology" => "01",
                      "infrastructure_technology" => "01",
                      "production_technology" => "02",
                      "profit_and_loss" => "01",
                      "master_name_result" => "01",
                    }

  NUM_GROUP = {
                 "cash_and_cash_equivalents" => "01",
                 "receivables" => "02",
                 "prepaid_expenses" => "03",
                 "taxes_and_contributions_to_be_recovered" => "04",
                 "group_loans" => "05",
                 "tangible" => "01",
                 "intagible" => "02",
                 "payables" => "01",
                 "accrued_profit_and_loss" => "03",
                 "people_expenses" => "01",
                 "technology_expenses" => "02",
                 "operating_expenses" => "01",
                 "group_result" => "01",
               }

  NUM_MASTER_GROUP = {
                        "current" => "01",
                        "not_current" => "02",
                        "net_equity" => "03",
                        "operating_expenses" => "01",
                        "master_group_result" => "01",
                      }

  NUM_MASTER = {
                  "asset" => "1",
                  "liability" => "2",
                  "revenues" => "3",
                  "expenses" => "4",
                  "result" => "5",
                  "taxes" => "6",
                }

end