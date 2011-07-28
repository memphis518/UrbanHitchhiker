require 'test_helper'

class UserTest < ActiveSupport::TestCase
  self.use_instantiated_fixtures  = true

  def test_required
    u = User.new(:password => "newpassword", :password_confirmation => "newpassword", :email => "badbob@mcbob.com", 
                 :firstname => "bad", :lastname => "bob")
    assert !u.save     
    assert u.errors.any?
    u = User.new(:username => "badbob", :password_confirmation => "newpassword", :email => "badbob@mcbob.com", 
                 :firstname => "bad", :lastname => "bob")
    assert !u.save     
    assert u.errors.any?
    u = User.new(:username => "badbob", :password => "newpassword", :email => "badbob@mcbob.com", 
                 :firstname => "bad", :lastname => "bob")
    assert !u.save     
    assert u.errors.any?
    u = User.new(:username => "badbob", :password => "newpassword", :password_confirmation => "newpassword",
                 :firstname => "bad", :lastname => "bob")
    assert !u.save     
    assert u.errors.any?
    u = User.new(:username => "badbob", :password => "newpassword", :password_confirmation => "newpassword", :email => "badbob@mcbob.com", 
                 :lastname => "bob")
    assert !u.save     
    assert u.errors.any?
    u = User.new(:username => "badbob", :password => "newpassword", :password_confirmation => "newpassword", :email => "badbob@mcbob.com", 
                 :firstname => "bad")
    assert !u.save     
    assert u.errors.any?
    u = User.new(:username => "badbob", :password => "newpassword", :password_confirmation => "wrong", :email => "badbob@mcbob.com", 
                  :firstname => "bad", :lastname => "bob")
    assert !u.save     
    assert u.errors.any?
    u = User.new(:username => "badbob", :password => "newpassword", :password_confirmation => "newpassword", :email => "badbob@mcbob.com", 
                  :firstname => "bad", :lastname => "bob")
    assert u.save     
    assert !u.errors.any?
  end
  
  
  def test_auth
    #check that we can username we a valid user 
    assert_equal  @bob, User.authenticate("bob", "test1234")    
    #wrong username
    assert_nil    User.authenticate("nonbob", "test1234")
    #wrong password
    assert_nil    User.authenticate("bob", "wrongpass")
    #wrong username and pass
    assert_nil    User.authenticate("nonbob", "wrongpass")
  end

  def test_disallowed_passwords
    #check thaat we can't create a user with any of the disallowed paswords
    u = User.new    
    u.username = "nonbob"
    u.email = "nonbob@mcbob.com"
    u.firstname = "non"
    u.lastname = "bob"
    #too short
    u.password = u.password_confirmation = "tiny" 
    assert !u.save     
    assert u.errors['password'].any?
    #too long
    u.password = u.password_confirmation = "hugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehuge"
    assert !u.save     
    assert u.errors['password'].any?
    #empty
    u.password = u.password_confirmation = ""
    assert !u.save    
    assert u.errors['password'].any?
    #ok
    u.password = u.password_confirmation = "bobs_secure_password"
    assert u.save     
    assert u.errors.empty? 
  end

  def test_bad_usernames
    #check we cant create a user with an invalid username
    u = User.new  
    u.password = u.password_confirmation = "bobs_secure_password"
    u.email = "okbob@mcbob.com"
    u.firstname = "ok"
    u.lastname = "bob"
    #too short
    u.username = "x"
    assert !u.save     
    assert u.errors['username'].any?
    #too long
    u.username = "hugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhug"
    assert !u.save     
    assert u.errors['username'].any?
    #empty
    u.username = ""
    assert !u.save
    assert u.errors['username'].any?
    #ok
    u.username = "okbob"
    assert u.save  
    assert u.errors.empty?

  end

  def test_bad_emails
    u = User.new  
    u.password = u.password_confirmation = "bobs_secure_password"
    u.firstname = "ok"
    u.lastname = "bob"
    u.username = 'bobuser
    '
    #no email
    u.email=nil   
    assert !u.save     
    assert u.errors['email'].any?
    #invalid email
    u.email='notavalidemail'   
    assert !u.save     
    assert u.errors['email'].any?
    #ok
    u.email="validbob@mcbob.com"
    assert u.save  
    assert u.errors.empty?
  end 

  def test_collision
    #check can't create new user with existing username
    u = User.new
    u.username = "existingbob"
    u.password = u.password_confirmation = "bobs_secure_password"
    assert !u.save
  end


  def test_create
    #check create works and we can authenticate after creation
    u = User.new
    u.username = "nonexistingbob"
    u.password = u.password_confirmation = "bobs_secure_password"
    u.email="nonexistingbob@mcbob.com"  
    u.firstname = "nonexisting"
    u.lastname = "bob"
    assert u.save
    assert_equal u, User.authenticate(u.username, u.password)

    u = User.new(:username => "newbob", :password => "newpassword", :password_confirmation => "newpassword", 
                 :email => "newbob@mcbob.com", :firstname => "new", :lastname => "bob")
    assert_not_nil u.password
    assert_not_nil u.hashed_password
    assert u.save 
    assert_equal u, User.authenticate(u.username, u.password)

  end

  def test_sha1
    u=User.new
    u.username      = "nonexistingbob"
    u.email="nonexistingbob@mcbob.com"
    u.firstname = "nonexisting"
    u.lastname = "bob"
    u.password = u.password_confirmation = "test1234"
    assert u.save   
    assert_equal '9bc34549d565d9505b287de0cd20ac77be1d3f2c', u.hashed_password
  end

  def test_protected_attributes
    #check attributes are protected
    u = User.new(:id=>999999, :username => "badbob", :password => "newpassword", :password_confirmation => "newpassword", 
                 :email => "newbob@mcbob.com", :firstname => "bad", :lastname => "bob")
    assert u.save
    assert_not_equal 999999, u.id

    u.update_attributes(:id=>999999, :username => "verybadbob")
    assert u.save
    assert_not_equal 999999, u.id
    assert_equal "verybadbob", u.username
  end
end