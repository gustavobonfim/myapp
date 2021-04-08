class API::V1::Financials::Books::Cards::EntitiesController < ApplicationController

  def create
    card = ::Financials::Books::Cards::Entities::Create.new(params)
    render :json => {:save => card.save, :data => card.data, :status => card.status, :type => card.type, :message => card.message}.as_json
  end

  def update
    card = ::Financials::Books::Cards::Entities::Update.new(params)
    render :json => {:save => card.save, :data => card.data, :status => card.status, :type => card.type, :message => card.message}.as_json
  end

  def update_paid
    card = ::Financials::Books::Cards::Entities::UpdatePaid.new(params)
    render :json => {:save => card.save, :data => card.data, :status => card.status, :type => card.type, :message => card.message}.as_json
  end

  def read
    card = ::Financials::Books::Cards::Entities::Read.new(params)
    render :json => {:data => card.data, :status => card.status, :process => card.process?, :type => card.type, :message => card.message}.as_json
  end

  def list
    list = ::Financials::Books::Cards::Entities::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end