module API
  module V1
    module Commercial
      module Sales
        module Opportunities
          class LeadsController < ApplicationController

            # skip_before_action :require_user, only: [:list, :create, :read, :update]
            skip_before_action :verify_authenticity_token

            def create
              lead = ::Commercial::Sales::Opportunities::Leads::Create.new(params)
              render :json => {:save => lead.save, :data => lead.data, :status => lead.status, :type => lead.type, :message => lead.message}.as_json
            end

            def update
              lead = ::Commercial::Sales::Opportunities::Leads::Update.new(params)
              render :json => {:save => lead.save, :data => lead.data, :status => lead.status, :type => lead.type, :message => lead.message}.as_json
            end

            def read
              lead = ::Commercial::Sales::Opportunities::Leads::Read.new(params)
              render :json => {:data => lead.data, :status => lead.status, :process => lead.process?, :type => lead.type, :message => lead.message}.as_json
            end

            def list
              list = ::Commercial::Sales::Opportunities::Leads::List.new(params)
              render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
            end
            
          end
        end
      end
    end
  end
end