require 'test_helper'
require 'users_controller'

# Re-raise errors caught by the controller.
class UserController; def rescue_action(e) raise e end; end

class UsersControllerTest < ActionController::TestCase

  self.use_instantiated_fixtures  = true
 
  def test_auth_bob
    #check we can login
    post :login, :username => "bob", :password => "test1234" 
    assert_not_nil session[:user_id]
    assert_equal @bob[:id], session[:user_id]
    assert_response :redirect
    assert_redirected_to :action=>'edit', :id => @bob[:id] 
  end

  def test_create
    #check we can signup and then login
    post :create, :user => { :username => "newbob", :password => "newpassword", :password_confirmation => "newpassword", :email => "newbob@mcbob.com",
                             :firstname => 'New', :lastname => 'Bob' }
    assert_response :redirect
    assert_not_nil session[:user_id]
    assert_redirected_to :action=>'edit', :id => session[:user_id]
  end

  def test_bad_create
    #check we can't signup without all required fields
    post :create, :user => { :username => "newbob", :password => "newpassword", :password_confirmation => "wrong" , :email => "newbob@mcbob.com",
                             :firstname => 'New', :lastname => 'Bob' }
    assert_response :success
    assert_template "users/new"
    assert_nil session[:user_id]

    post :create, :user => { :username => "yo", :password => "newpassword", :password_confirmation => "newpassword" , :email => "newbob@mcbob.com",
                             :firstname => 'New', :lastname => 'Bob' }
    assert_response :success
    assert_template "users/new"
    assert_nil session[:user_id]

    post :create, :user => { :username => "yo", :password => "newpassword", :password_confirmation => "wrong" , :email => "newbob@mcbob.com",
                             :firstname => 'New', :lastname => 'Bob' }
    assert_response :success
    assert_template "users/new"
    assert_nil session[:user_id]
  end

  def test_invalid_username
    #can't login with incorrect password
    post :login, :username => "bob", :password => "not_correct" 
    assert_response :success
    assert_nil session[:user_id]
    assert_template "users/loginfailed"
  end

  def test_username_required
    #can't access trips if not logged in
    get(:edit, :id => "1000001")
    assert_response :redirect
    assert_redirected_to :action=>'login'
    #username
    post :login, :username => "bob", :password => "test1234"
    assert_response :redirect
    assert_not_nil session[:user_id]
    #can access it now
    get(:edit, :id => "1000001")
    assert_response :success
    assert_template "users/edit"
  end

  def test_return_to
    #cant access trips without being logged in
    get(:edit, :id => @longbob[:id])
    assert_response :redirect
    assert_redirected_to :action=>'login'
    assert_not_nil session[:return_to]
    #username
    post :login, :username => "longbob", :password => "test1234"
    assert_response :redirect
    #redirected to hidden instead of default welcome
    assert_redirected_to :action=>'edit', :id => @longbob[:id] 
    assert_nil session[:return_to]
    assert_not_nil session[:user_id]
  end
  
end
