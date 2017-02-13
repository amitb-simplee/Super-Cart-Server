class Item
  include Mongoid::Document
  field :name, type: String
  field :quantity, type: String
  field :note, type: String

  embedded_in :cart, :inverse_of => :items
end
