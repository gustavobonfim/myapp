module API
  module V1
    module Operations
      module Products
        module Config
          class EntitiesController < ApplicationController

            def create
              product = ::Operations::Products::Config::Entities::Create.new(params)
              render :json => {:save => product.save, :data => product.data, :status => product.status, :type => product.type, :message => product.message}.as_json
            end

            def update
              product = ::Operations::Products::Config::Entities::Update.new(params)
              render :json => {:save => product.save, :data => product.data, :status => product.status, :type => product.type, :message => product.message}.as_json
            end
            
            def read
              product = ::Operations::Products::Config::Entities::Read.new(params)
              render :json => {:status => product.status, :process => product.process?, :type => product.type, :message => product.message, :data => product.data}.as_json
            end

            def list
              list = ::Operations::Products::Config::Entities::List.new(params)
              render :json => {:status => list.status, :process => list.process?, :type => list.type, :message => list.message, :data => list.data}.as_json
            end

            def get_room
              room = ::Operations::Products::Config::Entities::GetRoom.new(params)
              render :json => {:data => room.data, :process => room.process?, :type => room.type, :message => room.message}.as_json
            end

            def get_calculations
              calculations = ::Operations::Products::Config::Entities::GetCalculations.new(params)
              render :json => {:data => calculations.data, :process => calculations.process?, :type => calculations.type, :message => calculations.message}.as_json
            end
            

          end
        end
      end
    end
  end
end