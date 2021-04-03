class API::V1::Financials::Balances::Payables::EntitiesController < ApplicationController

  def create
    payables = ::Financials::Balances::Payables::Entities::Create.new(params)
    render :json => {:save => payables.save, :data => payables.data, :status => payables.status, :type => payables.type, :message => payables.message}.as_json
  end

  def update
    payables = ::Financials::Balances::Payables::Entities::Update.new(params)
    render :json => {:save => payables.save, :data => payables.data, :status => payables.status, :type => payables.type, :message => payables.message}.as_json
  end

  def read
    payables = ::Financials::Balances::Payables::Entities::Read.new(params)
    render :json => {:data => payables.data, :status => payables.status, :process => payables.process?, :type => payables.type, :message => payables.message}.as_json
  end

  def list
    list = ::Financials::Balances::Payables::Entities::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end