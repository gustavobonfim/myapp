class RenameColumnFromCommercialCalculations < ActiveRecord::Migration[5.2]
  def change
    rename_column :commercial_calculations, :count_prospecting, :prospecting_count
    rename_column :commercial_calculations, :count_qualification, :qualification_count
    rename_column :commercial_calculations, :count_booking, :booking_count
    rename_column :commercial_calculations, :count_meeting, :meeting_count
    rename_column :commercial_calculations, :count_proposal, :proposal_count
    rename_column :commercial_calculations, :count_closing, :closing_count
    rename_column :commercial_calculations, :count_gain, :gain_count
    rename_column :commercial_calculations, :count_lost, :lost_count


    add_column :commercial_calculations, :prospecting_amount, :decimal, default: 0, precision: 15, scale: 2 
    add_column :commercial_calculations, :qualification_amount, :decimal, default: 0, precision: 15, scale: 2 
    add_column :commercial_calculations, :booking_amount, :decimal, default: 0, precision: 15, scale: 2 
    add_column :commercial_calculations, :meeting_amount, :decimal, default: 0, precision: 15, scale: 2 
    add_column :commercial_calculations, :proposal_amount, :decimal, default: 0, precision: 15, scale: 2 
    add_column :commercial_calculations, :closing_amount, :decimal, default: 0, precision: 15, scale: 2 
    add_column :commercial_calculations, :gain_amount, :decimal, default: 0, precision: 15, scale: 2 
    add_column :commercial_calculations, :lost_amount, :decimal, default: 0, precision: 15, scale: 2 
  end
end
