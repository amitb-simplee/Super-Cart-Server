class Cart
  include Mongoid::Document
  field :date, type: Date , default: ->{ Time.zone.now }
  field :name, type: String

  embeds_many :items
end
