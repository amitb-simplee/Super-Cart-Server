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
  end

  def move_item(new_position, old_position)
  	self.items.insert(new_position,self.items.delete_at(old_position))
  end

  def create_item(item_params = {})
    item = Item.new(item_params)
    items << item unless item.nil?     
  end

  def add_user(user_id)
    self.users << user_id unless users.include? user_id
  end
end
