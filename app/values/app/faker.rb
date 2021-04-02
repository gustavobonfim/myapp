
class App::Faker
  # require 'clipboard'

  def self.cpf
    generated = "#{Faker::IDNumber.brazilian_citizen_number}"
    puts generated
  end

  def self.cnpj
    generated = "#{Faker::Company.brazilian_company_number}"
    puts generated
  end

  def self.name
    generated = "#{Faker::Name.name}"
    puts generated
  end

end

# sudo apt-get install xclip
