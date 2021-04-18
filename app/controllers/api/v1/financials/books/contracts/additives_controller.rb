class API::V1::Financials::Books::Contracts::AdditivesController < ApplicationController

  def create
    addtive = ::Financials::Books::Contracts::Additives::Create.new(params)
    render :json => {:save => addtive.save, :data => addtive.data, :status => addtive.status, :type => addtive.type, :message => addtive.message}.as_json
  end

  def update
    addtive = ::Financials::Books::Contracts::Additives::Update.new(params)
    render :json => {:save => addtive.save, :data => addtive.data, :status => addtive.status, :type => addtive.type, :message => addtive.message}.as_json
  end

  def read
    addtive = ::Financials::Books::Contracts::Additives::Read.new(params)
    render :json => {:data => addtive.data, :status => addtive.status, :process => addtive.process?, :type => addtive.type, :message => addtive.message}.as_json
  end

  def list
    list = ::Financials::Books::Contracts::Additives::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end