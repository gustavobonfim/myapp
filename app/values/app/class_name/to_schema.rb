class App::ClassName::ToSchema

  TRANSLATE = {
                "users" => "User",
                "leads" => "Lead::Entity",
                "account_entity" => "User::Account::Entity",
                "company_entity" => "User::Company::Entity",
                "operation_products" => "Operation::Product::Entity",
                "operation_dates" => "Operation::Product::Date",
                
                # tax_return
                "tax_return_incomes" => "Operation::Product::TaxReturn::Income",
                "tax_return_payments" => "Operation::Product::TaxReturn::Payment",


                # booking
                "booking_receipts" => "Operation::Product::Booking::Receipt",
                "booking_payments" => "Operation::Product::Booking::Payment",
                "booking_provisions" => "Operation::Product::Booking::Provision",

                # tax_filing
                "tax_filing_files" => "Operation::Product::TaxFiling::File",
                "tax_filing_journeys" => "Operation::Product::TaxFiling::Journey",
                "tax_filing_tickets" => "Operation::Product::TaxFiling::Ticket",

                # Commercial
                "commercial_dates" => "Commercial::Config::Date",
                "sales_opportunities" => "Commercial::Sale::Opportunity::Entity",
                "marketing_events" => "Commercial::Marketing::Event::Entity",

                # Financial
                "financials_dates" => "Financials::Config::Date",
                "products_purchases" => "Financials::Products::Purchase::Entity",

                # User Works
                "work_meetings" => "User::Work::Meeting::Weekly",

                # User Works
                "tracker_projects" => "User::Work::Tracker::Project",
                "tracker_stories" => "User::Work::Tracker::Story",

              }

end