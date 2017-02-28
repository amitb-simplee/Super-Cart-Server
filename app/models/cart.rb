class Cart
  include Mongoid::Document
  field :date, type: Date , default: ->{ Time.zone.now }
  field :name, type: String
  field :admin, type: String
  field :users, type: Array, default: []

  embeds_many :items

  attr_accessible :name, :admin, :items

  def initalize(params = {})
  	super #must be called with mongoid
    #TODO raise if admin user not found
  end

  def move_item(new_position, old_position)
  	self.items.insert(new_position,self.items.delete_at(old_position))
  end

  def create_item(item_params = {})
    item = Item.new(item_params)
    items << item unless item.nil?     
  end

  def add_user(user)
    #TODO raise if user not found
    unless users.include? user.email
      self.users << user.email
      self.save!
    end
  end

  def remove_user(user)
    if users.include? user.email
      self.users.delete(user.email)
      self.save!
    end
  end
end
