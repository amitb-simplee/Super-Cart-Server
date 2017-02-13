class Cart
  include Mongoid::Document
  field :date, type: Date , default: ->{ Time.zone.now }
  field :name, type: String

  embeds_many :items

  attr_accessor :name

  def initalize
  	super #must be called with mongoid
  end

  def move_item(new_position, old_position)
  	self.items.insert(new_position,self.items.delete_at(old_position))
  end

end
