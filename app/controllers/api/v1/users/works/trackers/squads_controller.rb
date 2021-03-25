module API
  module V1
		module Users
			module Works
				module Trackers
					class SquadsController < ApplicationController

						def create
							squad = ::Users::Works::Trackers::Squads::Create.new(params)
							render :json => {:save => squad.save, :data => squad.data, :status => squad.status, :type => squad.type, :message => squad.message}.as_json
						end

						def update
							squad = ::Users::Works::Trackers::Squads::Update.new(params)
							render :json => {:save => squad.save, :data => squad.data, :status => squad.status, :type => squad.type, :message => squad.message}.as_json
						end

						def destroy
							squad = ::Users::Works::Trackers::Squads::Destroy.new(params)
							render :json => {:save => squad.save, :data => squad.data, :status => squad.status, :type => squad.type, :message => squad.message}.as_json
						end
						
						def read
							squad = ::Users::Works::Trackers::Squads::Read.new(params)
							render :json => {:data => squad.data, :status => squad.status, :process => squad.process?, :type => squad.type, :message => squad.message}.as_json
						end

						def list
							list = ::Users::Works::Trackers::Squads::List.new(params)
							render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
						end

					end
				end
			end
		end
	end
end