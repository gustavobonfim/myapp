class Financials::Books::Contracts::CreateCalculationService

  def initialize(date, taker_id)
    @date = date

    @attrs = {}
    @attrs = @attrs.merge({ "date_id" => @date.id })

    if taker_id
      @attrs = @attrs.merge({ "taker_id" => taker_id })
      @calculation = calculation

      create_calculation
    else
      @takers = takers
      @takers.each do |taker|
        @attrs = @attrs.merge({ "taker_id" => taker.id })
        @calculation = calculation

        create_calculation
      end
    end
    
  end

  def create_calculation

    if @calculation.valid?
      @calculation.save
    end

  end


  def calculation
    ::Financials::Books::Contracts::CalculationRepository.build(@attrs)
  end

  def takers
    ::Financials::Books::Contracts::TakerRepository.all_active
  end
  
  
  
end