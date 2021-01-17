class Commercial::Sales::Leads::EntityMapper < BaseMapper

  def self.map(model)
    obj = model.attributes

    obj = obj.merge({ "sources" => ::Commercial::Sales::Leads::SourceRepository.list(model.sources.where(active: true)) })

    return obj
  end

end