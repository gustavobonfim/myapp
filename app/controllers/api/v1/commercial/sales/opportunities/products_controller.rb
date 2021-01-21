module API
  module V1
    module Commercial
      module Sales
        module Opportunities
          class ProductsController < ApplicationController

            # skip_before_action :require_user, only: [:list, :create, :read, :update]
            skip_before_action :verify_authenticity_token

            def create
              product = ::Commercial::Sales::Opportunities::Products::Create.new(params)
              render :json => {:save => product.save, :data => product.data, :status => product.status, :type => product.type, :message => product.message}.as_json
            end

            def update
              product = ::Commercial::Sales::Opportunities::Products::Update.new(params)
              render :json => {:save => product.save, :data => product.data, :status => product.status, :type => product.type, :message => product.message}.as_json
            end

            def read
              product = ::Commercial::Sales::Opportunities::Products::Read.new(params)
              render :json => {:data => product.data, :status => product.status, :process => product.process?, :type => product.type, :message => product.message}.as_json
            end

            def list
              list = ::Commercial::Sales::Opportunities::Products::List.new(params)
              render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
            end

            def destroy
              product = ::Commercial::Sales::Opportunities::Products::Destroy.new(params)
              render :json => {:save => product.save, :data => product.data, :status => product.status, :type => product.type, :message => product.message}.as_json
            end
            
          end
        end
      end
    end
  end
end