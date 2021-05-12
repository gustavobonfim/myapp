class API::V1::Operations::Onboards::EntitiesController < ApplicationController

  def create
    onboard = ::Operations::Onboards::Entities::Create.new(params)
    render :json => {:save => onboard.save, :data => onboard.data, :status => onboard.status, :type => onboard.type, :message => onboard.message}.as_json
  end

  def update
    onboard = ::Operations::Onboards::Entities::Update.new(params)
    render :json => {:save => onboard.save, :data => onboard.data, :status => onboard.status, :type => onboard.type, :message => onboard.message}.as_json
  end

  def read
    onboard = ::Operations::Onboards::Entities::Read.new(params)
    render :json => {:data => onboard.data, :status => onboard.status, :process => onboard.process?, :type => onboard.type, :message => onboard.message}.as_json
  end

  def list
    list = ::Operations::Onboards::Entities::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end