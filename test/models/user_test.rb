require "test_helper"

describe User do
  before do
    @user = User.create(username: 'john', email: 'john@example.com')#users(:valid)
    # @user.save!
  end
  describe 'relations' do
    it 'can have products' do
      @user.must_respond_to :products
    end

    it 'can have no products' do
      assert_equal 0, @user.products.size
    end

    it 'can have one product' do
      @user.products << Product.new
      assert_equal 1, @user.products.size
    end
    it 'can have orders' do
      @user.must_respond_to :orders
    end

    it 'can have one order' do
      @user.orders << Order.new
      assert_equal 1, @user.orders.size
    end

    it 'can have reviews' do
      @user.must_respond_to :reviews
    end
  end

  describe 'validation' do
  
    it 'invalid without username' do
      user = users(:invalid_without_username)
      user.valid?.must_equal false
      user.errors.messages.must_include :username
      # @user.username = nil
      # refute @user.valid?, 'saved user without a username'
      # assert_not_nil @user.errors[:username], 'no validation error for username present'
    end
  
    it 'invalid without email' do
      user = users(:invalid_without_email)
      user.valid?.must_equal false
      user.errors.messages.must_include :email
      # @user.email = nil
      # refute @user.valid?, 'saved user without an email'
      # assert_not_nil @user.errors[:email], 'no validation error for email present'

    end
    
    it "requires a unique username" do
      username = "test username"
      email = 'test@email.com'
      user1 = User.new(username: username, email: email)

      # This must go through, so we use create!
      user1.save!

      user2 = User.new(username: username, email: email)
      result = user2.save
      result.must_equal false
      user2.errors.messages.must_include :username
    end
   
    
    it 'requires an unique email' do
      username1 = "testusername"
      email = 'test@email.com'
      user1 = User.new(username: username1, email: email)

      # This must go through, so we use create!
      user1.save!
      username2 = "test2username"
      user2 = User.new(username: username2, email: email)
      result = user2.save
      result.must_equal false
      user2.errors.messages.must_include :email
    end
  end
end
