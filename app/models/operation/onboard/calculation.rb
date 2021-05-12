class Operation::Onboard::Calculation < ApplicationRecord

  self.table_name = "operation_onboard_calculations"
  
  # Relations
  belongs_to :date, class_name: "Operation::Onboard::Date", foreign_key: "date_id"
  
  # Validations

  # Enums

  # Callbacks
  
  
end