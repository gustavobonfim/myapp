class API::V1::Financials::Books::Payables::EntitiesController < ApplicationController

  def create
    payable = ::Financials::Books::Payables::Entities::Create.new(params)
    render :json => {:save => payable.save, :data => payable.data, :status => payable.status, :type => payable.type, :message => payable.message}.as_json
  end

  def update
    payable = ::Financials::Books::Payables::Entities::Update.new(params)
    render :json => {:save => payable.save, :data => payable.data, :status => payable.status, :type => payable.type, :message => payable.message}.as_json
  end

  def update_paid
    payable = ::Financials::Books::Payables::Entities::UpdatePaid.new(params)
    render :json => {:save => payable.save, :data => payable.data, :status => payable.status, :type => payable.type, :message => payable.message}.as_json
  end

  def read
    payable = ::Financials::Books::Payables::Entities::Read.new(params)
    render :json => {:data => payable.data, :status => payable.status, :process => payable.process?, :type => payable.type, :message => payable.message}.as_json
  end

  def list
    list = ::Financials::Books::Payables::Entities::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end