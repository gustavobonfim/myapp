class Financials::Books::Receivables::ConciliationMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "kind_pretty" => Financials::Books::Receivables::ConciliationRepository::ENUM_RECEIVABLE_KIND[model.receivable_kind] })
    obj = obj.merge({ "status_pretty" => ::Financials::Books::Receivables::ConciliationRepository::ENUM_STATUS[model.status] })

    return obj
  end

end