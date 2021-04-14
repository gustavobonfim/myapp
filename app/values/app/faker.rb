
class App::Faker
  # require 'clipboard'

  def self.cpf
    generated = "#{Faker::IDNumber.brazilian_citizen_number}"
    puts generated
    return generated
  end

  def self.cnpj
    generated = "#{Faker::Company.brazilian_company_number}"
    puts generated
    return generated
  end

  def self.name
    generated = "#{Faker::Name.name}"
    puts generated
    return generated
  end

  def self.company
    generated = "#{Faker::Company.name} LTDA"
    puts generated
    return generated
  end

end

# sudo apt-get install xclip

# App::Faker.cpf
# App::Faker.cnpj
# App::Faker.name
# App::Faker.company
