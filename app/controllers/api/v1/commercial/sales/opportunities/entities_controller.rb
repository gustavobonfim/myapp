module API
  module V1
    module Commercial
      module Sales
        module Opportunities
          class EntitiesController < ApplicationController

            # skip_before_action :require_user, only: [:list, :create, :read, :update]
            skip_before_action :verify_authenticity_token

            def create
              opportunity = ::Commercial::Sales::Opportunities::Entities::Create.new(params)
              render :json => {:save => opportunity.save, :data => opportunity.data, :status => opportunity.status, :type => opportunity.type, :message => opportunity.message}.as_json
            end

            def update
              opportunity = ::Commercial::Sales::Opportunities::Entities::Update.new(params)
              render :json => {:save => opportunity.save, :data => opportunity.data, :status => opportunity.status, :type => opportunity.type, :message => opportunity.message}.as_json
            end

            def read
              opportunity = ::Commercial::Sales::Opportunities::Entities::Read.new(params)
              render :json => {:status => opportunity.status, :process => opportunity.process?, :type => opportunity.type, :message => opportunity.message, :data => opportunity.data}.as_json
            end

            def list
              list = ::Commercial::Sales::Opportunities::Entities::List.new(params)
              render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
            end
            
          end
        end
      end
    end
  end
end