module API
  module V1
    module Commercial
      module Sales
        module Leads
          class SourcesController < ApplicationController

            # skip_before_action :require_user, only: [:list, :create, :read, :update]
            skip_before_action :verify_authenticity_token
            
            def list
              list = ::Commercial::Sales::Leads::Sources::List.new(params)
              render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
            end
            
          end
        end
      end
    end
  end
end