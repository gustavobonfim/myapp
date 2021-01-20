class Commercial::Sales::Leads::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "created_at_pretty" => DateDecorator.abbr_month_date(model.created_at) })
    obj = obj.merge({ "primary_source_pretty" => ::Commercial::Sales::Leads::EntityRepository::ENUM_SOURCE[model.primary_source] })
    obj = obj.merge({ "status_pretty" => ::Commercial::Sales::Leads::EntityRepository::ENUM_STATUS[model.status] })
    obj = obj.merge({ "sources" => ::Commercial::Sales::Leads::SourceRepository.list(model.sources.where(active: true)) })
    obj = obj.merge({ "opportunity_path" => "http://localhost:3000/oportunidades" })

    return obj
  end

end