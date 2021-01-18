module API
  module V1
    module Commercial
      module Sales
        module Opportunities
          class TicketsController < ApplicationController

            # skip_before_action :require_user, only: [:list, :create, :read, :update]
            skip_before_action :verify_authenticity_token

            def create
              ticket = ::Commercial::Sales::Opportunities::Tickets::Create.new(params)
              render :json => {:save => ticket.save, :data => ticket.data, :status => ticket.status, :type => ticket.type, :message => ticket.message}.as_json
            end

            def update
              ticket = ::Commercial::Sales::Opportunities::Tickets::Update.new(params)
              render :json => {:save => ticket.save, :data => ticket.data, :status => ticket.status, :type => ticket.type, :message => ticket.message}.as_json
            end

            def read
              ticket = ::Commercial::Sales::Opportunities::Tickets::Read.new(params)
              render :json => {:data => ticket.data, :status => ticket.status, :process => ticket.process?, :type => ticket.type, :message => ticket.message}.as_json
            end

            def list
              list = ::Commercial::Sales::Opportunities::Tickets::List.new(params)
              render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
            end
            
          end
        end
      end
    end
  end
end