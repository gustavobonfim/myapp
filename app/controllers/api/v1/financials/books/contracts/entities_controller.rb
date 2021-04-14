class API::V1::Financials::Books::Contracts::EntitiesController < ApplicationController

  def create
    contract = ::Financials::Books::Contracts::Entities::Create.new(params)
    render :json => {:save => contract.save, :data => contract.data, :status => contract.status, :type => contract.type, :message => contract.message}.as_json
  end

  def update
    contract = ::Financials::Books::Contracts::Entities::Update.new(params)
    render :json => {:save => contract.save, :data => contract.data, :status => contract.status, :type => contract.type, :message => contract.message}.as_json
  end

  def read
    contract = ::Financials::Books::Contracts::Entities::Read.new(params)
    render :json => {:data => contract.data, :status => contract.status, :process => contract.process?, :type => contract.type, :message => contract.message}.as_json
  end

  def list
    list = ::Financials::Books::Contracts::Entities::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end