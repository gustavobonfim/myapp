module API
  module V1
    module Commercial
      module Config
        class CalculationsController < ApplicationController

          # skip_before_action :require_user, only: [:list, :create, :read, :update]
          skip_before_action :verify_authenticity_token

          def update
            calculation = ::Commercial::Config::Calculations::Update.new(params)
            render :json => {:save => calculation.save, :data => calculation.data, :status => calculation.status, :type => calculation.type, :message => calculation.message}.as_json
          end
        
        end
      end
    end
  end
end