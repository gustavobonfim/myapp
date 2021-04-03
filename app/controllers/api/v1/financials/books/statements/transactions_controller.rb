class API::V1::Financials::Books::Statements::TransactionsController < ApplicationController

  def create
    transaction = ::Financials::Books::Statements::Transactions::Create.new(params)
    render :json => {:save => transaction.save, :data => transaction.data, :status => transaction.status, :type => transaction.type, :message => transaction.message}.as_json
  end

  def update
    transaction = ::Financials::Books::Statements::Transactions::Update.new(params)
    render :json => {:save => transaction.save, :data => transaction.data, :status => transaction.status, :type => transaction.type, :message => transaction.message}.as_json
  end

  def read
    transaction = ::Financials::Books::Statements::Transactions::Read.new(params)
    render :json => {:data => transaction.data, :status => transaction.status, :process => transaction.process?, :type => transaction.type, :message => transaction.message}.as_json
  end

  def list
    list = ::Financials::Books::Statements::Transactions::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end