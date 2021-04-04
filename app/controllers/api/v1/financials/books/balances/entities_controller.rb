class API::V1::Financials::Books::Balances::EntitiesController < ApplicationController

  def create
    balance = ::Financials::Books::Balances::Entities::Create.new(params)
    render :json => {:save => balance.save, :data => balance.data, :status => balance.status, :type => balance.type, :message => balance.message}.as_json
  end

  def update
    balance = ::Financials::Books::Balances::Entities::Update.new(params)
    render :json => {:save => balance.save, :data => balance.data, :status => balance.status, :type => balance.type, :message => balance.message}.as_json
  end

  def refresh
    balance = ::Financials::Books::Balances::Entities::Refresh.new(params)
    render :json => {:save => balance.save, :data => balance.data, :status => balance.status, :type => balance.type, :message => balance.message}.as_json
  end

  def read
    balance = ::Financials::Books::Balances::Entities::Read.new(params)
    render :json => {:data => balance.data, :status => balance.status, :process => balance.process?, :type => balance.type, :message => balance.message}.as_json
  end

  def list
    list = ::Financials::Books::Balances::Entities::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end