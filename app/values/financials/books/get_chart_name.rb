class Financials::Books::GetChartName

  #[:product_name][:kind][:product_kind]

  TRANSLATE = {
                "medclinic" => {
                                  "setup" => {
                                                "receivement" => "PJ Médica | Serviços Avulsos",
                                                "practice" => "PJ Médica | Serviços Avulsos"
                                              },
                                  "recurring" => {
                                                    "receivement" => "PJ Médica | Mensalidade PJ Recebimento",
                                                    "practice" => "PJ Médica | Mensalidade PJ Consultório"
                                                  },
                                },
                "medbooking" => {
                                    "setup" => {
                                                  "receivement" => "Livro-Caixa | Serviços Avulsos",
                                                  "practice" => "Livro-Caixa | Serviços Avulsos"
                                                },
                                    "recurring" => {
                                                      "receivement" => "Livro-Caixa | Mensalidade Livro-Caixa",
                                                      "practice" => "Livro-Caixa | Mensalidade Livro-Caixa"
                                                    },
                                  },
                "medfiling" => {
                                  "setup" => {
                                                "receivement" => "Imposto de Renda | Serviços Avulsos",
                                              },
                                  "recurring" => {
                                                    "receivement" => "Imposto de Renda | Mensalidade Imposto de Renda",
                                                  },
                                },
                "medpayroll" => {
                                  "setup" => {
                                                "receivement" => "Folha de Pagamento | Serviços Avulsos",
                                                "practice" => "Folha de Pagamento | Serviços Avulsos"
                                              },
                                  "recurring" => {
                                                    "receivement" => "Folha de Pagamento | Mensalidade Funcionários eSocial",
                                                    "practice" => "Folha de Pagamento | Mensalidade Funcionários Consultório"
                                                  },
                                },
                "medreceivement" => {
                                  "setup" => {
                                                "receivement" => "Gestão de Recebimentos | Serviços Avulsos",
                                              },
                                  "recurring" => {
                                                    "receivement" => "Gestão de Recebimentos | Mensalidade Gestão de Recebimentos",
                                                  },
                                },
                "medbiling" => {
                                  "setup" => {
                                                "practice" => "Faturamento | Serviços Avulsos",
                                              },
                                  "recurring" => {
                                                    "practice" => "Faturamento | Mensalidade Faturamento",
                                                  },
                                },
                "medprotection" => {
                                      "setup" => {
                                                    "receivement" => "Faturamento | Serviços Avulsos",
                                                  },
                                      "recurring" => {
                                                        "receivement" => "Faturamento | Mensalidade Faturamento",
                                                      },
                                    },
                "medconsulting" => {
                                      "setup" => {
                                                    "none" => "Consultorias e Avulsos | Consultorias e Avulsos",
                                                  },
                                      "recurring" => {
                                                        "none" => "Consultorias e Avulsos | Consultorias e Avulsos",
                                                      },
                                    },
              }


end