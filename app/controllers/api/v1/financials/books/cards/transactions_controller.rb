class API::V1::Financials::Books::Cards::TransactionsController < ApplicationController

  def create
    bill = ::Financials::Books::Cards::Transactions::Create.new(params)
    render :json => {:save => bill.save, :data => bill.data, :status => bill.status, :type => bill.type, :message => bill.message}.as_json
  end

  def update
    bill = ::Financials::Books::Cards::Transactions::Update.new(params)
    render :json => {:save => bill.save, :data => bill.data, :status => bill.status, :type => bill.type, :message => bill.message}.as_json
  end

  def update_paid
    bill = ::Financials::Books::Cards::Transactions::UpdatePaid.new(params)
    render :json => {:save => bill.save, :data => bill.data, :status => bill.status, :type => bill.type, :message => bill.message}.as_json
  end

  def read
    bill = ::Financials::Books::Cards::Transactions::Read.new(params)
    render :json => {:data => bill.data, :status => bill.status, :process => bill.process?, :type => bill.type, :message => bill.message}.as_json
  end

  def list
    list = ::Financials::Books::Cards::Transactions::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end