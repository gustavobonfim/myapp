class API::V1::Financials::Books::Receivables::EntitiesController < ApplicationController

  def create
    receivable = ::Financials::Books::Receivables::Entities::Create.new(params)
    render :json => {:save => receivable.save, :data => receivable.data, :status => receivable.status, :type => receivable.type, :message => receivable.message}.as_json
  end

  def create_single
    receivable = ::Financials::Books::Receivables::Entities::CreateSingle.new(params)
    render :json => {:save => receivable.save, :data => receivable.data, :status => receivable.status, :type => receivable.type, :message => receivable.message}.as_json
  end

  def create_multiple
    receivable = ::Financials::Books::Receivables::Entities::CreateMultiple.new(params)
    render :json => {:save => receivable.save, :data => receivable.data, :status => receivable.status, :type => receivable.type, :message => receivable.message}.as_json
  end

  def update
    receivable = ::Financials::Books::Receivables::Entities::Update.new(params)
    render :json => {:save => receivable.save, :data => receivable.data, :status => receivable.status, :type => receivable.type, :message => receivable.message}.as_json
  end

  def update_paid
    receivable = ::Financials::Books::Receivables::Entities::UpdatePaid.new(params)
    render :json => {:save => receivable.save, :data => receivable.data, :status => receivable.status, :type => receivable.type, :message => receivable.message}.as_json
  end

  def read
    receivable = ::Financials::Books::Receivables::Entities::Read.new(params)
    render :json => {:data => receivable.data, :status => receivable.status, :process => receivable.process?, :type => receivable.type, :message => receivable.message}.as_json
  end

  def list
    list = ::Financials::Books::Receivables::Entities::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end