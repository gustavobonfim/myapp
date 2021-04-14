class API::V1::Financials::Books::Contracts::CalculationsController < ApplicationController

  def read
    taker = ::Financials::Books::Contracts::Calculations::Read.new(params)
    render :json => {:data => taker.data, :status => taker.status, :process => taker.process?, :type => taker.type, :message => taker.message}.as_json
  end

  def list
    list = ::Financials::Books::Contracts::Calculations::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end