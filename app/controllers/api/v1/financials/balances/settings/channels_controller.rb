class API::V1::Financials::Balances::Settings::ChannelsController < ApplicationController

  def create
    channel = ::Financials::Balances::Settings::Channels::Create.new(params)
    render :json => {:save => channel.save, :data => channel.data, :status => channel.status, :type => channel.type, :message => channel.message}.as_json
  end

  def update
    channel = ::Financials::Balances::Settings::Channels::Update.new(params)
    render :json => {:save => channel.save, :data => channel.data, :status => channel.status, :type => channel.type, :message => channel.message}.as_json
  end

  def read
    channel = ::Financials::Balances::Settings::Channels::Read.new(params)
    render :json => {:data => channel.data, :status => channel.status, :process => channel.process?, :type => channel.type, :message => channel.message}.as_json
  end

  def list
    list = ::Financials::Balances::Settings::Channels::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end