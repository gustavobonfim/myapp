class Commercial::Config::CalculationMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    if model.goal_leads > 0
      obj = obj.merge({ "leads_rate" => (model.marketing_leads.to_d * 100) / model.goal_leads.to_d })
    else
      obj = obj.merge({ "leads_rate" => 0 })
    end

    if model.goal_amount > 0
      obj = obj.merge({ "amount_rate" => (model.total_amount * 100) / model.goal_amount })
    else
      obj = obj.merge({ "amount_rate" => 0 })
    end

    if model.goal_gain > 0
      obj = obj.merge({ "gain_rate" => (model.total_gain * 100) / model.goal_gain })
    else
      obj = obj.merge({ "gain_rate" => 0 })
    end

    return obj
  end

end