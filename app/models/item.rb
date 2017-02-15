class Item
  include Mongoid::Document
  field :name, type: String
  field :quantity, type: String
  field :note, type: String
  field :checked, type: Boolean
  
  embedded_in :cart, :inverse_of => :items

  attr_accessible :name, :quantity, :note, :checked

  def initalize
  	super #must be called with mongoid
  #   self.name = params.fetch(:name)
  #   self.quantity = params.fetch(:quantity)
  #   self.note = params.fetch(:note)
  #   self.checked = false
  end

  def create(params = {})
    super

    self.name = params.fetch(:name)
    self.quantity = params.fetch(:quantity)
    self.note = params.fetch(:note)
    self.checked = false
  end

end
