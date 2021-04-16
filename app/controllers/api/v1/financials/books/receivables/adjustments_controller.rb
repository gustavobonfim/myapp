class API::V1::Financials::Books::Receivables::AdjustmentsController < ApplicationController

  def create
    adjustment = ::Financials::Books::Receivables::Adjustments::Create.new(params)
    render :json => {:save => adjustment.save, :data => adjustment.data, :status => adjustment.status, :type => adjustment.type, :message => adjustment.message}.as_json
  end

  def update
    adjustment = ::Financials::Books::Receivables::Adjustments::Update.new(params)
    render :json => {:save => adjustment.save, :data => adjustment.data, :status => adjustment.status, :type => adjustment.type, :message => adjustment.message}.as_json
  end

  def update_paid
    adjustment = ::Financials::Books::Receivables::Adjustments::UpdatePaid.new(params)
    render :json => {:save => adjustment.save, :data => adjustment.data, :status => adjustment.status, :type => adjustment.type, :message => adjustment.message}.as_json
  end

  def read
    adjustment = ::Financials::Books::Receivables::Adjustments::Read.new(params)
    render :json => {:data => adjustment.data, :status => adjustment.status, :process => adjustment.process?, :type => adjustment.type, :message => adjustment.message}.as_json
  end

  def list
    list = ::Financials::Books::Receivables::Adjustments::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end