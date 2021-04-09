class API::V1::Financials::Books::Cards::BillsController < ApplicationController

  def update
    bill = ::Financials::Books::Cards::Bills::Update.new(params)
    render :json => {:save => bill.save, :data => bill.data, :status => bill.status, :type => bill.type, :message => bill.message}.as_json
  end

  def update_paid
    bill = ::Financials::Books::Cards::Bills::UpdatePaid.new(params)
    render :json => {:save => bill.save, :data => bill.data, :status => bill.status, :type => bill.type, :message => bill.message}.as_json
  end

  def close_bill
    bill = ::Financials::Books::Cards::Bills::CloseBill.new(params)
    render :json => {:save => bill.save, :data => bill.data, :status => bill.status, :type => bill.type, :message => bill.message}.as_json
  end

  def read
    bill = ::Financials::Books::Cards::Bills::Read.new(params)
    render :json => {:data => bill.data, :status => bill.status, :process => bill.process?, :type => bill.type, :message => bill.message}.as_json
  end

  def list
    list = ::Financials::Books::Cards::Bills::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end