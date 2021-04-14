class API::V1::Financials::Books::Contracts::TakersController < ApplicationController

  def create
    taker = ::Financials::Books::Contracts::Takers::Create.new(params)
    render :json => {:save => taker.save, :data => taker.data, :status => taker.status, :type => taker.type, :message => taker.message}.as_json
  end

  def update
    taker = ::Financials::Books::Contracts::Takers::Update.new(params)
    render :json => {:save => taker.save, :data => taker.data, :status => taker.status, :type => taker.type, :message => taker.message}.as_json
  end

  def read
    taker = ::Financials::Books::Contracts::Takers::Read.new(params)
    render :json => {:data => taker.data, :status => taker.status, :process => taker.process?, :type => taker.type, :message => taker.message}.as_json
  end

  def list
    list = ::Financials::Books::Contracts::Takers::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end