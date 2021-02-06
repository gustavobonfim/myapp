module API
  module V1
    module Operations
      module Products
        module Config
          class DatesController < ApplicationController

            def create
              date = ::Operations::Products::Config::Dates::Create.new(params)
              render :json => {:save => date.save, :status => date.status, :type => date.type, :message => date.message, :data => date.data}.as_json
            end

            def update
              date = ::Operations::Products::Config::Dates::Update.new(params)
              render :json => {:save => date.save, :status => date.status, :type => date.type, :message => date.message, :data => date.data}.as_json
            end
            
            def read
              date = ::Operations::Products::Config::Dates::Read.new(params)
              render :json => {:status => date.status, :process => date.process?, :type => date.type, :message => date.message, :data => date.data}.as_json
            end

            def list
              list = ::Operations::Products::Config::Dates::List.new(params)
              render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
            end

          end
        end
      end
    end
  end
end