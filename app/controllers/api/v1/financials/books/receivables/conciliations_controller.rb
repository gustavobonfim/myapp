class API::V1::Financials::Books::Receivables::ConciliationsController < ApplicationController

  def list
    list = ::Financials::Books::Receivables::Conciliations::List.new(params)
    render :json => {:data => list.data, :status => list.status, :process => list.process?, :type => list.type, :message => list.message}.as_json
  end
  
end