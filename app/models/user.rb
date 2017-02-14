class User
  include Mongoid::Document
  field :email, type: String
  field :password_hash, type: String
  field :password_salt, type: String
  field :carts, type: Array, default: []

  before_save :encrypt_password

  attr_accessor :password
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def self.authenticate(email, password)
    user = find_by(:email => email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
  	if password.present?
  	  self.password_salt = BCrypt::Engine.generate_salt
  	  self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  	end
  end

  def create_cart(name)
  	cart = Cart.create!(admin: self._id, name: name)
  	self.carts << cart._id unless cart.nil?
  end

  def add_cart(cart_id)
  	#validate that cart exists
  	cart = Cart.find(cart_id)
    # TODO send exception if cart does not exist 
    unless self.carts.include?(cart._id)
  	  self.carts << cart._id
      self.save!
    end

    cart.add_user(self._id)
    cart.save!

  end

  def remove_cart(cart_id)
    cart = Cart.find(cart_id)
    # TODO send exception if cart does not exist
    if cart.admin == self._id.to_s
      users = User.where(id: { :$in => cart.users})
      users.each{ |u| u.remove_cart(cart_id)}
      Cart.find(cart_id).delete
    end

    self.carts = self.carts - [cart_id]
    self.save!
    
  end

end
