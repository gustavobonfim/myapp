FactoryBot.define do
  factory :project do
    name { Faker::Name.female_first_name }
    token { Faker::IDNumber.brazilian_citizen_number }
    slug { token }
    unit { %w[develop marketing].sample }
    status { %w[frozen in_progress canceled finished].sample }
    # kind { %i[admin doctor helper team patient].sample }
  end
end