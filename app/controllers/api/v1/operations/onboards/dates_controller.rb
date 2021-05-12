module API
  module V1
    module Operations
      module Onboards
        class DatesController < ApplicationController

          def read
            date = ::Operations::Onboards::Dates::Read.new(params)
            render :json => {:data => date.data, :status => date.status, :process => date.process?, :type => date.type, :message => date.message}.as_json
          end

          def list
            list = ::Operations::Onboards::Dates::List.new(params)
            render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
          end
          
        end
      end
    end
  end
end