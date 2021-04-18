class Financials::Books::Receivables::Calculations::CreateService

  def initialize(date, med_id)
    @date = date

    @attrs = {}
    @attrs = @attrs.merge({ "date_id" => @date.id })

    if med_id
      @attrs = @attrs.merge({ "med_id" => med_id })
      @calculation = calculation

      create_calculation
    else
      @meds = meds
      @meds.each do |med|
        @attrs = @attrs.merge({ "med_id" => med.id })
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
    ::Financials::Books::Receivables::CalculationRepository.build(@attrs)
  end

  def meds
    ::Users::Companies::EntityRepository.all_active_by_kind("med")
  end
  
end