module API
  module V1
    module Commercial
      module Marketing
        module Leads
          class GenerationsController < ApplicationController

            # skip_before_action :require_user, only: [:list, :create, :read, :update]
            skip_before_action :verify_authenticity_token
            
            def list_attendee
              list = ::Commercial::Marketing::Leads::Generations::ListAttendee.new(params)
              render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
            end

            def list_landings
              list = ::Commercial::Marketing::Leads::Generations::ListLandings.new(params)
              render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
            end
            
          end
        end
      end
    end
  end
end