module API
  module V1
    module Commercial
      module Config
        class DatesController < ApplicationController

          # skip_before_action :require_user, only: [:list, :create, :read, :update]
          skip_before_action :verify_authenticity_token

          def create
            opportunity = ::Commercial::Config::Dates::Create.new(params)
            render :json => {:save => opportunity.save, :data => opportunity.data, :status => opportunity.status, :type => opportunity.type, :message => opportunity.message}.as_json
          end

          def update
            opportunity = ::Commercial::Config::Dates::Update.new(params)
            render :json => {:save => opportunity.save, :data => opportunity.data, :status => opportunity.status, :type => opportunity.type, :message => opportunity.message}.as_json
          end

          def list
            list = ::Commercial::Config::Dates::List.new(params)
            render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
          end
          
        end
      end
    end
  end
end