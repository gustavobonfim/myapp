class Commercial::Sales::Leads::CreateSourceService

  def initialize(attrs)
    
    @source = ::Commercial::Sales::Leads::SourceRepository.build(attrs)

  end

  def save_source

    if @source.valid?
      @source.save
      # atualizar de acordo com a fonte: Evento, Landing, Visits
    end
    
  end
  
end