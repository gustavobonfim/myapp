class API::V1::Financials::Balances::Payables::ProvidersController < ApplicationController

  def create
    provider = ::Financials::Balances::Payables::Providers::Create.new(params)
    render :json => {:save => provider.save, :data => provider.data, :status => provider.status, :type => provider.type, :message => provider.message}.as_json
  end

  def update
    provider = ::Financials::Balances::Payables::Providers::Update.new(params)
    render :json => {:save => provider.save, :data => provider.data, :status => provider.status, :type => provider.type, :message => provider.message}.as_json
  end

  def read
    provider = ::Financials::Balances::Payables::Providers::Read.new(params)
    render :json => {:data => provider.data, :status => provider.status, :process => provider.process?, :type => provider.type, :message => provider.message}.as_json
  end

  def list
    list = ::Financials::Balances::Payables::Providers::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end