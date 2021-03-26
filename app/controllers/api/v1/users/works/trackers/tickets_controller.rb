module API
  module V1
		module Users
			module Works
				module Trackers
					class TicketsController < ApplicationController

						def create
							ticket = ::Users::Works::Trackers::Tickets::Create.new(params)
							render :json => {:save => ticket.save, :data => ticket.data, :status => ticket.status, :type => ticket.type, :message => ticket.message}.as_json
						end

						def update
							ticket = ::Users::Works::Trackers::Tickets::Update.new(params)
							render :json => {:save => ticket.save, :data => ticket.data, :status => ticket.status, :type => ticket.type, :message => ticket.message}.as_json
						end

						def destroy
							ticket = ::Users::Works::Trackers::Tickets::Destroy.new(params)
							render :json => {:save => ticket.save, :data => ticket.data, :status => ticket.status, :type => ticket.type, :message => ticket.message}.as_json
						end

						def list
							list = ::Users::Works::Trackers::Tickets::List.new(params)
							render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
						end

					end
				end
			end
		end
	end
end