class Financials::Books::Contracts::CalculationMapper < BaseMapper

  def self.map(model)    
    obj = model.attributes

    if model.invoice_token == nil || model.invoice_token == ""
      obj = obj.merge({ "has_invoice" => false })
      obj = obj.merge({ "status_alert" => true })
    else
      obj = obj.merge({ "has_invoice" => true })
      if model.invoice_status == "pending" || model.invoice_status == "canceled" || model.invoice_status == "expired"
        obj = obj.merge({ "status_alert" => true })  
      else
        obj = obj.merge({ "status_alert" => false })  
      end
    end
    
    return obj
  end

end