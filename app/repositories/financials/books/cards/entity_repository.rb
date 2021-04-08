class Financials::Books::Cards::EntityRepository < Base

  def self.build(attrs)
    obj = entity.new
    obj.attributes = attrs
    obj.token = set_token("token").upcase
    
    return obj
  end

  def self.find_and_change(attrs)
    obj = entity.find_by(id: attrs["id"])
    obj.attributes = attrs

    return obj
  end

  def self.all_active
    entity.where(active: true).includes(:med)
  end

  def self.all_active_by_date(date_id)
    entity.where(active: true, date_id: date_id)
  end

  def self.find_by_id(id)
    entity.find_by(id: id)
  end

  def self.find_by_date(date_id)
    entity.find_by(date_id: date_id)
  end

  def self.read(card)
    mapper.map(card)
  end
  
  def self.list(cards)
    mapper.map_all(cards)
  end

  def self.clean_database
    # Financials::Books::Cards::EntityRepository.clean_database

    if Rails.env == "development"
      Financial::Book::Card::Entity.all.each do |card|
        Financial::Book::Transaction::Entity.where(token_tree: card.token).destroy_all

        card.destroy
      end
    end    
  end
  
  private

  def self.entity
    "Financial::Book::Card::Entity".constantize
  end

  def self.mapper
    "Financials::Books::Cards::EntityMapper".constantize
  end

  def self.set_token(field)
    token = Base.generate_token
    set_token if valid_field(field, token)
    token
  end

end