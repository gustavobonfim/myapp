module API
  module V1
		module Users
			module Works
				module Trackers
					class StoriesController < ApplicationController

						def create
							story = ::Users::Works::Trackers::Stories::Create.new(params)
							render :json => {:save => story.save, :data => story.data, :status => story.status, :type => story.type, :message => story.message}.as_json
						end

						def update
							story = ::Users::Works::Trackers::Stories::Update.new(params)
							render :json => {:save => story.save, :data => story.data, :status => story.status, :type => story.type, :message => story.message}.as_json
						end

						def destroy
							story = ::Users::Works::Trackers::Stories::Destroy.new(params)
							render :json => {:save => story.save, :data => story.data, :status => story.status, :type => story.type, :message => story.message}.as_json
						end
						
						def read
							story = ::Users::Works::Trackers::Stories::Read.new(params)
							render :json => {:data => story.data, :status => story.status, :process => story.process?, :type => story.type, :message => story.message}.as_json
						end

						def list
							list = ::Users::Works::Trackers::Stories::List.new(params)
							render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
						end

					end
				end
			end
		end
	end
end