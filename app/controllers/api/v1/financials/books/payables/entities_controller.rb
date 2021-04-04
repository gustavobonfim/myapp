class API::V1::Financials::Books::Payables::EntitiesController < ApplicationController

  def create
    payables = ::Financials::Books::Payables::Entities::Create.new(params)
    render :json => {:save => payables.save, :data => payables.data, :status => payables.status, :type => payables.type, :message => payables.message}.as_json
  end

  def update
    payables = ::Financials::Books::Payables::Entities::Update.new(params)
    render :json => {:save => payables.save, :data => payables.data, :status => payables.status, :type => payables.type, :message => payables.message}.as_json
  end

  def update_paid
    payables = ::Financials::Books::Payables::Entities::UpdatePaid.new(params)
    render :json => {:save => payables.save, :data => payables.data, :status => payables.status, :type => payables.type, :message => payables.message}.as_json
  end

  def read
    payables = ::Financials::Books::Payables::Entities::Read.new(params)
    render :json => {:data => payables.data, :status => payables.status, :process => payables.process?, :type => payables.type, :message => payables.message}.as_json
  end

  def list
    list = ::Financials::Books::Payables::Entities::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end