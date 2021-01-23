class Commercial::Sales::Opportunities::UpdateOpportunityProductsService

  def initialize(products)
    @products = products
  end

  def update_products
    @products.each do |opportunity_product|
      product = ::Commercial::Sales::Opportunities::ProductRepository.find_by_id(opportunity_product[:id])
      product.gain = opportunity_product[:gain]
      product.lost = opportunity_product[:lost]

      product.save
    end
    
  end
  
end