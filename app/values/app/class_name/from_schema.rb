class App::ClassName::FromSchema

  TRANSLATE = {
                "User" => "users",
                "User::Account::Entity" => "account_entity",
                "User::Company::Entity" => "company_entity",
                "Operation::Product::Entity" => "operation_products",
                "Operation::Product::Dates" => "operation_dates",
                
                # tax_return
                "Operation::Product::TaxReturn::Income" => "tax_return_incomes",
                "Operation::Product::TaxReturn::Payment" => "tax_return_payments",
                "Operation::Product::TaxReturn::Document" => "tax_return_documents",

                # booking
                "Operation::Product::Booking::Receipt" => "booking_receipts",
                "Operation::Product::Booking::Payment" => "booking_payments",
                "Operation::Product::Booking::Provision" => "booking_provisions",
                "Operation::Product::Booking::Document" => "booking_documents",

                # tax_filing
                "Operation::Product::TaxFiling::File" => "tax_filing_files",
                "Operation::Product::TaxFiling::Journey" => "tax_filing_journeys",
                "Operation::Product::TaxFiling::Ticket" => "tax_filing_tickets",

                "Commercial::Config::Date" => "commercial_dates",
                "Commercial::Sale::Opportunity::Entity" => "sales_opportunities",

              }

end