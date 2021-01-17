module API
  module V1
    module Commercial
      module Sales
        module Opportunities
          class JourneysController < ApplicationController

            # skip_before_action :require_user, only: [:list, :create, :read, :update]
            skip_before_action :verify_authenticity_token

            def create
              journey = ::Commercial::Sales::Opportunities::Journeys::Create.new(params)
              render :json => {:save => journey.save, :data => journey.data, :status => journey.status, :type => journey.type, :message => journey.message}.as_json
            end

            def update
              journey = ::Commercial::Sales::Opportunities::Journeys::Update.new(params)
              render :json => {:save => journey.save, :data => journey.data, :status => journey.status, :type => journey.type, :message => journey.message}.as_json
            end

            def read
              journey = ::Commercial::Sales::Opportunities::Journeys::Read.new(params)
              render :json => {:data => journey.data, :status => journey.status, :process => journey.process?, :type => journey.type, :message => journey.message}.as_json
            end

            def list
              list = ::Commercial::Sales::Opportunities::Journeys::List.new(params)
              render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
            end
            
          end
        end
      end
    end
  end
end