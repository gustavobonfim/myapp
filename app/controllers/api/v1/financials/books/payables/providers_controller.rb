class API::V1::Financials::Books::Payables::ProvidersController < ApplicationController

  def create
    provider = ::Financials::Books::Payables::Providers::Create.new(params)
    render :json => {:save => provider.save, :data => provider.data, :status => provider.status, :type => provider.type, :message => provider.message}.as_json
  end

  def update
    provider = ::Financials::Books::Payables::Providers::Update.new(params)
    render :json => {:save => provider.save, :data => provider.data, :status => provider.status, :type => provider.type, :message => provider.message}.as_json
  end

  def read
    provider = ::Financials::Books::Payables::Providers::Read.new(params)
    render :json => {:data => provider.data, :status => provider.status, :process => provider.process?, :type => provider.type, :message => provider.message}.as_json
  end

  def list
    list = ::Financials::Books::Payables::Providers::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end