class API::V1::Financials::Books::Settings::ChartAccountsController < ApplicationController

  def create
  chart = ::Financials::Books::Settings::ChartAccounts::Create.new(params)
  render :json => {:save => chart.save, :data => chart.data, :status => chart.status, :type => chart.type, :message => chart.message}.as_json
  end

  def update
    chart = ::Financials::Books::Settings::ChartAccounts::Update.new(params)
    render :json => {:save => chart.save, :data => chart.data, :status => chart.status, :type => chart.type, :message => chart.message}.as_json
  end

  def read
    chart = ::Financials::Books::Settings::ChartAccounts::Read.new(params)
    render :json => {:data => chart.data, :status => chart.status, :process => chart.process?, :type => chart.type, :message => chart.message}.as_json
  end

  def list
    list = ::Financials::Books::Settings::ChartAccounts::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end