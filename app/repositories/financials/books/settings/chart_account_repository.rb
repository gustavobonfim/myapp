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
                        "availabilities"=>"Disponibilidades",
                        "short_term_financial_investments"=>"Aplicações Financeiras de Curto Prazo",
                        "clients"=>"Clientes",
                        "miscellaneous_credits"=>"Créditos Diversos",
                        "prepaid_expenses"=>"Antecipação Despesas",
                        "taxes_to_be_recovered"=>"Impostos a Recuperar",
                        "contribuition_and_others_to_be_recovered"=>"Contribuições e Outros a Recuperar",
                        "mutual_receivable"=>"Mútuos a Receber",
                        "fixed_assets"=>"Ativos Permanentes",
                        "long_term_financial_investments"=>"Aplicações Financeiras de Longo Prazo",
                        "branding_know_how"=>"Marcas e Know-how",
                        "staff_payables"=>"Pessoal a Pagar",
                        "expense_payables"=>"Despesas a Pagar",
                        "wage_payables"=>"Remunerações a Pagar",
                        "labor_obligations_payables"=>"Encargos Trabalhistas a Pagar",
                        "benefits_payables"=>"Benefícios a Pagar",
                        "taxes_payables"=>"Impostos a Pagar",
                        "fees"=>"Taxas a Pagar",
                        "bank_loan"=>"Empréstimo Bancário Curto Prazo",
                        "credit_card"=>"Cartão de Crédito",
                        "financing"=>"Financiamentos",
                        "partners_refund_payables"=>"Reembolsos a Fazer",
                        "client_advance_revenues"=>"Recebimentos Antecipados",
                        "mutual_payables"=>"Mútuos a Pagar",
                        "long_term_bank_loan"=>"Empréstimo Bancário Longo Prazo",
                        "long_term_partner_loan"=>"Empréstimo Sócios",
                        "convertible_mutual"=>"Mútuo Conversível",
                        "liabilities_provision"=>"Provisões de Passivos",
                        "capital_stock"=>"Capital Social",
                        "capital_reserves"=>"Reserva de Capital",
                        "profit_reserves"=>"Reserva de Lucros",
                        "profit_and_loss"=>"Lucro/Prejuízo",
                        "dividend_distribution"=>"Distribuição de Dividendos",
                        "medclinics"=>"PJ Médica",
                        "medbooking"=>"Livro-Caixa",
                        "medfiling"=>"Imposto de Renda",
                        "medpayroll"=>"Funcionários",
                        "medreceivement"=>"Gestão de Recebimento",
                        "medbiling"=>"Faturamento",
                        "medinvestment"=>"Investimento",
                        "medprotection"=>"Previdência e Proteção",
                        "medmiscellaneous"=>"Consultorias e Avulsos",
                        "interests_revenues"=>"Juros",
                        "exchange_variation_revenues"=>"Receita Variação Cambial",
                        "miscellaneous_revenues"=>"Outros Receitas Financeiras",
                        "staff_technology"=>"Pessoal Tecnologia",
                        "staff_accounting"=>"Pessoal Controle",
                        "staff_biling"=>"Pessoal Faturamento",
                        "staff_investment"=>"Pessoal Acumulação",
                        "staff_protection"=>"Pessoal Proteção",
                        "staff_legal"=>"Pessoal Jurídico",
                        "staff_customer_success"=>"Pessoal Customer Success",
                        "infrastructure_technology_expenses"=>"Infraestrutura Tecnologia",
                        "production_technology_expenses"=>"Produção Tecnologia",
                        "accounting_expenses"=>"Despesas Controle",
                        "investment_expenses"=>"Despesas Acumulação",
                        "protection_expenses"=>"Despesas Proteção",
                        "customer_success_expenses"=>"Despesas Customer Success",
                        "people_sales"=>"Pessoal Vendas",
                        "people_marketing"=>"Pessoal Marketing",
                        "prospecting_expenses"=>"Despesas de Prospecção e Atendimento",
                        "offline_expenses"=>"Despesas OFFLINE",
                        "online_expenses"=>"Despesas ONLINE",
                        "staff_administrative"=>"Pessoal Administrativo",
                        "staff_board"=>"Despesas com Diretoria e Conselho",
                        "location_expenses"=>"Despesas com Localização",
                        "utilities_expenses"=>"Despesas com Utilidades",
                        "office_expenses"=>"Despesas com Escritório",
                        "human_capital_expenses"=>"Despesas com Capital Humano",
                        "staff_general"=>"Pessoal Serviços Gerais",
                        "bank_expenses"=>"Despesas Bancárias",
                        "outsourcing_expenses"=>"Serviços de Terceiros",
                        "taxes_and_fees_expenses"=>"Despesas com Tributos e Taxas",
                        "new_business_expenses"=>"Despesas Novos Negócios",
                        "benefits_expenses"=>"Despesas com Benefícios",
                        "maintenance_expenses"=>"Despesas com Manutenção",
                        "depreciation_expenses"=>"Despesas com Depreciação",
                        "fines_and_interests_expenses"=>"Juros e Multas",
                        "financial_taxes_expenses"=>"Impostos e Tributos",
                        "exchange_variation_expenses"=>"Despesa Variação Cambial",
                        "losses_realization"=>"Realização de Prejuízos",
                        "master_name_result"=>"Resultado",
                        "federal_taxes"=>"Federais",
                        "city_taxes"=>"Municipal"
                      }


  ENUM_GROUP = {
                "cash_and_cash_equivalents"=>"Disponibilidades e Equivalentes",
                "receivables"=>"A Receber",
                "prepaid_expenses_and_taxes"=>"Despesas e Impostos Antecipadas",
                "mutual_inside_group"=>"Mútuos no Grupo",
                "tangible"=>"Tangível",
                "intagible"=>"Intangível",
                "payables"=>"Contas a Pagar",
                "labor_and_social_obligations"=>"Obrigações Sociais e Trabalhistas",
                "taxes_and_others_obligations"=>"Obrigações Tributárias, Fiscais e Taxas",
                "short_term_financial_obligations"=>"Obrigações Financeiras de Curto Prazo",
                "refund_payables"=>"Reembolsos a Fazer",
                "advance_revenues"=>"Recebimentos Antecipados",
                "long_term_financial_obligations"=>"Obrigações Financeiras de Longo Prazo",
                "grant_liabilities_provision"=>"Provisões de Passivos",
                "grant_capital_stock"=>"Capital Social",
                "reserves"=>"Reservas",
                "accrued_profit_and_loss"=>"Lucro/Prejuízo Acumulado",
                "accounting"=>"Controle",
                "biling"=>"Faturamento",
                "investment"=>"Acumulação",
                "protection"=>"Proteção",
                "miscellaneous"=>"Outros",
                "financial_revenues"=>"Receitas Financeiras",
                "operation_staff_expenses"=>"Despesas Com Pessoal Operacional",
                "technology_expenses"=>"Despesas Com Tecnologia",
                "services_expenses"=>"Despesas com Serviços Prestados",
                "commercial_staff_expenses"=>"Despesas Com Pessoal Comercial",
                "sales_expenses"=>"Despesas com Vendas",
                "marketing_expenses"=>"Despesas com Marketing",
                "administrative_staff_expenses"=>"Despesas Com Pessoal Administrativo",
                "administrative_expenses"=>"Despesas Administrativas",
                "general_staff_expenses"=>"Despesas com Pessoal Geral",
                "general_expenses"=>"Despesas Gerais",
                "grant_depreciation_expenses"=>"Despesas com Depreciação",
                "financial_expenses"=>"Despesas Financeiras",
                "grant_losses_realization"=>"Realização de Prejuízos",
                "group_result"=>"Resultado",
                "taxes_and_contributions"=>"Impostos e Contribuições"
              }

  ENUM_MASTER_GROUP = {
                        "current"=>"Circulante",
                        "non_current"=>"Não-Circulante",
                        "net_equity"=>"Patrimônio Líquido",
                        "operation_revenues"=>"Receitas Operacionais",
                        "non_operation_revenues"=>"Receitas Não-Operacionais",
                        "operating_expenses"=>"Despesas Operacionais",
                        "commercial_expenses"=>"Despesas Comerciais",
                        "general_and_administrative_expenses"=>"Despesas Gerais e Administrativas",
                        "non_operation_expenses"=>"Despesas Não-Operacionais",
                        "master_group_result"=>"Resultado",
                        "grant_taxes_and_contributions"=>"Impostos e Contribuições"
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
                      "availabilities"=>"01",
                      "short_term_financial_investments"=>"02",
                      "clients"=>"01",
                      "miscellaneous_credits"=>"02",
                      "prepaid_expenses"=>"01",
                      "taxes_to_be_recovered"=>"02",
                      "contribuition_and_others_to_be_recovered"=>"03",
                      "mutual_receivable"=>"01",
                      "fixed_assets"=>"01",
                      "long_term_financial_investments"=>"02",
                      "branding_know_how"=>"01",
                      "staff_payables"=>"01",
                      "expense_payables"=>"02",
                      "wage_payables"=>"01",
                      "labor_obligations_payables"=>"02",
                      "benefits_payables"=>"03",
                      "taxes_payables"=>"01",
                      "fees"=>"02",
                      "bank_loan"=>"01",
                      "credit_card"=>"02",
                      "financing"=>"03",
                      "partners_refund_payables"=>"01",
                      "client_advance_revenues"=>"01",
                      "mutual_payables"=>"01",
                      "long_term_bank_loan"=>"01",
                      "long_term_partner_loan"=>"02",
                      "convertible_mutual"=>"03",
                      "liabilities_provision"=>"01",
                      "capital_stock"=>"01",
                      "capital_reserves"=>"01",
                      "profit_reserves"=>"02",
                      "profit_and_loss"=>"01",
                      "dividend_distribution"=>"02",
                      "medclinics"=>"01",
                      "medbooking"=>"02",
                      "medfiling"=>"03",
                      "medpayroll"=>"04",
                      "medreceivement"=>"01",
                      "medbiling"=>"02",
                      "medinvestment"=>"01",
                      "medprotection"=>"01",
                      "medmiscellaneous"=>"01",
                      "interests_revenues"=>"01",
                      "exchange_variation_revenues"=>"02",
                      "miscellaneous_revenues"=>"03",
                      "staff_technology"=>"01",
                      "staff_accounting"=>"02",
                      "staff_biling"=>"03",
                      "staff_investment"=>"04",
                      "staff_protection"=>"05",
                      "staff_legal"=>"06",
                      "staff_customer_success"=>"07",
                      "infrastructure_technology_expenses"=>"01",
                      "production_technology_expenses"=>"02",
                      "accounting_expenses"=>"01",
                      "investment_expenses"=>"02",
                      "protection_expenses"=>"03",
                      "customer_success_expenses"=>"04",
                      "people_sales"=>"01",
                      "people_marketing"=>"02",
                      "prospecting_expenses"=>"01",
                      "offline_expenses"=>"01",
                      "online_expenses"=>"02",
                      "staff_administrative"=>"01",
                      "staff_board"=>"02",
                      "location_expenses"=>"01",
                      "utilities_expenses"=>"02",
                      "office_expenses"=>"03",
                      "human_capital_expenses"=>"04",
                      "staff_general"=>"01",
                      "bank_expenses"=>"01",
                      "outsourcing_expenses"=>"02",
                      "taxes_and_fees_expenses"=>"03",
                      "new_business_expenses"=>"04",
                      "benefits_expenses"=>"05",
                      "maintenance_expenses"=>"06",
                      "depreciation_expenses"=>"01",
                      "fines_and_interests_expenses"=>"01",
                      "financial_taxes_expenses"=>"02",
                      "exchange_variation_expenses"=>"03",
                      "losses_realization"=>"01",
                      "master_name_result"=>"01",
                      "federal_taxes"=>"01",
                      "city_taxes"=>"02"
                    }


  NUM_GROUP = {
                "cash_and_cash_equivalents"=>"01",
                "receivables"=>"02",
                "prepaid_expenses_and_taxes"=>"03",
                "mutual_inside_group"=>"04",
                "tangible"=>"01",
                "intagible"=>"02",
                "payables"=>"01",
                "labor_and_social_obligations"=>"02",
                "taxes_and_others_obligations"=>"03",
                "short_term_financial_obligations"=>"04",
                "refund_payables"=>"05",
                "advance_revenues"=>"06",
                "long_term_financial_obligations"=>"01",
                "grant_liabilities_provision"=>"02",
                "grant_capital_stock"=>"01",
                "reserves"=>"02",
                "accrued_profit_and_loss"=>"03",
                "accounting"=>"01",
                "biling"=>"02",
                "investment"=>"03",
                "protection"=>"04",
                "miscellaneous"=>"05",
                "financial_revenues"=>"01",
                "operation_staff_expenses"=>"01",
                "technology_expenses"=>"02",
                "services_expenses"=>"03",
                "commercial_staff_expenses"=>"01",
                "sales_expenses"=>"02",
                "marketing_expenses"=>"03",
                "administrative_staff_expenses"=>"01",
                "administrative_expenses"=>"02",
                "general_staff_expenses"=>"03",
                "general_expenses"=>"04",
                "grant_depreciation_expenses"=>"01",
                "financial_expenses"=>"02",
                "grant_losses_realization"=>"03",
                "group_result"=>"01",
                "taxes_and_contributions"=>"01"
              }


  NUM_MASTER_GROUP = {
                        "current"=>"01",
                        "non_current"=>"02",
                        "net_equity"=>"03",
                        "operation_revenues"=>"01",
                        "non_operation_revenues"=>"02",
                        "operating_expenses"=>"01",
                        "commercial_expenses"=>"02",
                        "general_and_administrative_expenses"=>"03",
                        "non_operation_expenses"=>"04",
                        "master_group_result"=>"01",
                        "grant_taxes_and_contributions"=>"01"
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