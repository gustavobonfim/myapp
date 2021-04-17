class API::V1::Financials::Books::Receivables::InvoicesController < ApplicationController

  def create
    invoice = ::Financials::Books::Receivables::Invoices::Create.new(params)
    render :json => {:save => invoice.save, :data => invoice.data, :status => invoice.status, :type => invoice.type, :message => invoice.message}.as_json
  end

  def update
    invoice = ::Financials::Books::Receivables::Invoices::Update.new(params)
    render :json => {:save => invoice.save, :data => invoice.data, :status => invoice.status, :type => invoice.type, :message => invoice.message}.as_json
  end

  def update_paid
    invoice = ::Financials::Books::Receivables::Invoices::UpdatePaid.new(params)
    render :json => {:save => invoice.save, :data => invoice.data, :status => invoice.status, :type => invoice.type, :message => invoice.message}.as_json
  end

  def destroy
    invoice = ::Financials::Books::Receivables::Invoices::Destroy.new(params)
    render :json => {:save => invoice.save, :data => invoice.data, :status => invoice.status, :type => invoice.type, :message => invoice.message}.as_json
  end

  def read
    invoice = ::Financials::Books::Receivables::Invoices::Read.new(params)
    render :json => {:data => invoice.data, :status => invoice.status, :process => invoice.process?, :type => invoice.type, :message => invoice.message}.as_json
  end

  def list
    list = ::Financials::Books::Receivables::Invoices::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end