class Financials::Books::ChartAccounts::UpdateAllDependentsService

  def initialize(chart_account)
    @chart_account = chart_account

    update_dependents    
  end

  def update_dependents

    # Financial::Book::Setting::Channel.where(chart_id: @chart_account.id).each do |obj|
    #   obj.chart_name = @chart_account.chart_name
    #   obj.save
    # end


    Financial::Book::Balance::Entity.where(chart_id: @chart_account.id).each do |obj|
      obj.chart_name = @chart_account.chart_name
      obj.chart_code = @chart_account.token
      obj.save
    end

    Financial::Book::Payable::Entity.where(chart_id: @chart_account.id).each do |obj|
      obj.chart_account = @chart_account.chart_account
      obj.chart_name = @chart_account.chart_name
      obj.chart_master_name = @chart_account.master_name
      obj.chart_group = @chart_account.group
      obj.save
    end

    Financial::Book::Receivable::Entity.where(chart_id: @chart_account.id).each do |obj|
      obj.chart_account = @chart_account.chart_account
      obj.chart_name = @chart_account.chart_name
      obj.chart_master_name = @chart_account.master_name
      obj.chart_group = @chart_account.group
      obj.save
    end

    Financial::Book::Card::Transaction.where(chart_id: @chart_account.id).each do |obj|
      obj.chart_name = @chart_account.chart_name
      obj.save
    end

  end
  
end