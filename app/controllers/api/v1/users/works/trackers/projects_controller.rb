module API
  module V1
		module Users
			module Works
				module Trackers
					class ProjectsController < ApplicationController

						def create
							project = ::Users::Works::Trackers::Projects::Create.new(params)
							render :json => {:save => project.save, :data => project.data, :status => project.status, :type => project.type, :message => project.message}.as_json
						end

						def update
							project = ::Users::Works::Trackers::Projects::Update.new(params)
							render :json => {:save => project.save, :data => project.data, :status => project.status, :type => project.type, :message => project.message}.as_json
						end

						def destroy
							project = ::Users::Works::Trackers::Projects::Destroy.new(params)
							render :json => {:save => project.save, :data => project.data, :status => project.status, :type => project.type, :message => project.message}.as_json
						end
						
						def read
							project = ::Users::Works::Trackers::Projects::Read.new(params)
							render :json => {:data => project.data, :status => project.status, :process => project.process?, :type => project.type, :message => project.message}.as_json
						end

						def list
							list = ::Users::Works::Trackers::Projects::List.new(params)
							render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
						end

					end
				end
			end
		end
	end
end