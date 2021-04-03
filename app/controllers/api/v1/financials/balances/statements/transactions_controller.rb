class API::V1::Financials::Balances::Statements::TransactionsController < ApplicationController

  def create
    transaction = ::Financials::Balances::Statements::Transactions::Create.new(params)
    render :json => {:save => transaction.save, :data => transaction.data, :status => transaction.status, :type => transaction.type, :message => transaction.message}.as_json
  end

  def update
    transaction = ::Financials::Balances::Statements::Transactions::Update.new(params)
    render :json => {:save => transaction.save, :data => transaction.data, :status => transaction.status, :type => transaction.type, :message => transaction.message}.as_json
  end

  def read
    transaction = ::Financials::Balances::Statements::Transactions::Read.new(params)
    render :json => {:data => transaction.data, :status => transaction.status, :process => transaction.process?, :type => transaction.type, :message => transaction.message}.as_json
  end

  def list
    list = ::Financials::Balances::Statements::Transactions::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end