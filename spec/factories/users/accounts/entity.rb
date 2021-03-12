FactoryBot.define do
  factory :account do
    name { Faker::Name.name }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    # email { Faker::Internet.email(name: user.name, separators: '.') }
    # account { %w[admin doctor helper team patient].sample }
    # kind { %i[admin doctor helper team patient].sample }
  end
end