module API
  module V1
		module Users
			module Works
				module Trackers
					class RelationsController < ApplicationController

						def create
							relation = ::Users::Works::Trackers::Relations::Create.new(params)
							render :json => {:save => relation.save, :data => relation.data, :status => relation.status, :type => relation.type, :message => relation.message}.as_json
						end

						def destroy
							relation = ::Users::Works::Trackers::Relations::Destroy.new(params)
							render :json => {:save => relation.save, :data => relation.data, :status => relation.status, :type => relation.type, :message => relation.message}.as_json
						end
						
					end
				end
			end
		end
	end
end