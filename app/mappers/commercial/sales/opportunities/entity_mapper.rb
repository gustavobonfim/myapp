class Commercial::Sales::Opportunities::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    # obj = obj.merge({ "opportunity_path" => "#{ENV['DEFAULT_URL_HOST']}/a/oportunidades/#{model.slug}" })
    obj = obj.merge({ "url" => "http://localhost:3000/oportunidades/#{model.token}" })
    obj = obj.merge({ "started_at_pretty" => DateDecorator.abbr_month_date(model.started_at) })
    obj = obj.merge({ "open_days" => Date.current.day - model.started_at.day })
    obj = obj.merge({ "stage_pretty" => ::Commercial::Sales::Opportunities::EntityRepository::ENUM_STAGE[model.stage] })
    obj = obj.merge({ "stage_number" => model.class.stages[model.stage] })
    obj = obj.merge({ "status_pretty" => ::Commercial::Sales::Opportunities::EntityRepository::ENUM_STATUS[model.status] })
    obj = obj.merge({ "source_pretty" => ::Commercial::Sales::Opportunities::EntityRepository::ENUM_SOURCE[model.source] })
    obj = obj.merge({ "leads" => ::Commercial::Sales::Opportunities::LeadRepository.list(model.leads.where(active: true)) })
    obj = obj.merge({ "products" => ::Commercial::Sales::Opportunities::ProductRepository.list(model.products.where(active: true)) })
    obj = obj.merge({ "journeys" => ::Commercial::Sales::Opportunities::JourneyRepository.list(model.journeys.where(active: true)) })

    return obj
  end

end