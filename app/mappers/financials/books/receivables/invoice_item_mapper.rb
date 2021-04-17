class Financials::Books::Receivables::InvoiceItemMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "kind_pretty" => ::Financials::Books::Receivables::InvoiceItemRepository::ENUM_KIND[model.kind] })
    
    return obj
  end

end