class Item
  include Mongoid::Document
  field :name, type: String
  field :quantity, type: String
  field :note, type: String
  field :checked, type: Boolean
  
  embedded_in :cart, :inverse_of => :items

   def initalize
  	super #must be called with mongoid
  end
end
