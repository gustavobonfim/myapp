class API::V1::Financials::Books::Receivables::InvoicesController < ApplicationController

  def create
    adjustment = ::Financials::Books::Receivables::Invoices::Create.new(params)
    render :json => {:save => adjustment.save, :data => adjustment.data, :status => adjustment.status, :type => adjustment.type, :message => adjustment.message}.as_json
  end

  def update
    adjustment = ::Financials::Books::Receivables::Invoices::Update.new(params)
    render :json => {:save => adjustment.save, :data => adjustment.data, :status => adjustment.status, :type => adjustment.type, :message => adjustment.message}.as_json
  end

  def destroy
    adjustment = ::Financials::Books::Receivables::Invoices::Destroy.new(params)
    render :json => {:save => adjustment.save, :data => adjustment.data, :status => adjustment.status, :type => adjustment.type, :message => adjustment.message}.as_json
  end

  def read
    adjustment = ::Financials::Books::Receivables::Invoices::Read.new(params)
    render :json => {:data => adjustment.data, :status => adjustment.status, :process => adjustment.process?, :type => adjustment.type, :message => adjustment.message}.as_json
  end

  def list
    list = ::Financials::Books::Receivables::Invoices::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end