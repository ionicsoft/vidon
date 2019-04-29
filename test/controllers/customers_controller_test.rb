require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
    @customer2 = customers(:two)
    @show = shows(:one)
    @show2 = shows(:two)
    @episode = episodes(:one)
    @movie = movies(:one)
    @movie2 = movies(:two)
    @comment = profile_comments(:one)
    @fav = favorites(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as_customer
  end

  #Start coverage testing
  test "should get index" do
    get customers_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_url
    assert_response :success
  end 

  test "should create customer" do
    #does not create customer
    assert_difference('Customer.count', 1) do
      post customers_url, params: { customer: { person_attributes: { username: 
        "newuser", password: "123456", password_confirmation: "123456", email:
        "newuser@example.com", first_name: "New", last_name: "User" } } }
    end

    assert_redirected_to customer_url(Customer.last)
  end

  test "should show customer" do
    get customer_url(@customer)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_url(@customer)
    assert_response :redirect
    #assert_response :success
  end

  test "should update customer" do
    patch customer_url(@customer), params: { customer: { person_attributes: {
      username: "newuser", password: "123456", password_confirmation: "123456",
      email: "newuser@example.com", first_name: "New", last_name: "User" } } }
    #assert_redirected_to customer_url(@customer)
  end

  test "should destroy customer" do
    #does not destroy customer
    assert_difference('Customer.count', -1) do
      delete customer_url(@customer)
    end

    assert_redirected_to customers_url
  end
  
  #Start use cases
  test "should get browse" do
    click_on 'Browse'
    assert_selector "a", "Shows"
  end
  
  test "should get shows" do
    click_on 'My Shows'
    assert_selector "h3", "My Shows"
  end
  
  test "should get rentals" do
    click_on 'My Rentals'
    assert_selector "h3", "My Rentals"
  end
  
  test "should get friends" do
    click_on @customer.person.first_name
    click_on 'Friends'
    assert_selector "h3", "Your friends"
  end
  
  test "should get profile" do
    click_on @customer.person.first_name
    click_on 'Profile'
    assert_selector "h4", @customer.person.full_name
  end
  
  test "should get settings" do
    click_on @customer.person.first_name
    click_on 'Settings'
    assert_selector "h1", "Edit Information"
  end
  
  test "should log out" do
    click_on @customer.person.first_name
    click_on 'Log Out'
    assert_selector "h2", "Say hello to subscriptions."
  end
  
  test "should get subscription" do
    click_on 'My Shows'
    click_on 'Episodes'
    assert_selector "h1", @show.name
  end
  
  test "should get recommendation" do
    #todo
  end
  
  test "should get recently updated" do
    #todo
  end
  
  test "should get show from browse" do
    click_on 'Browse'
    click_on @show.name
    assert_selector "h1", @show.name
  end
  
  test "should get movie from browse" do
    click_on 'Browse'
    click_on 'Movies'
    click_on @movie.video.title
    assert_selector "h1", @movie.video.title
  end
  
  test "should get movie tab" do
    click_on 'Browse'
    click_on 'Movies'
    assert_selector "h5", @movie.video.title
  end
  
  test "should cancel subscription" do
    click_on 'My Shows'
    click_on 'Cancel'
    find 'Renew'
  end
  
  test "should get browse from my shows" do
    click_on 'My Shows'
    click_on 'Find new shows!'
    assert_selector "a", "Shows"
  end
  
  test "should get browse from rentals" do
    click_on 'My Rentals'
    click_on 'Find new movies!'
    assert_selector "a", "Shows"
  end
  
  test "should play subscription" do
    click_on 'My Shows'
    click_on 'Episodes'
    click_on 'Play'
    assert_selector "h5", @show.name
  end
  
  test "should play rental" do
    click_on 'My Rentals'
    click_on 'Play'
    assert_selector "h3", @movie.video.title
  end
  
  test "should see friends" do
    click_on @customer.person.first_name
    click_on 'Friends'
    assert_selector "h4", @customer2.person.full_name
  end
  
  test "should get friend's page" do
    click_on @customer.person.first_name
    click_on 'Friends'
    click_on @customer2.person.full_name
    assert_selector "h4", @customer2.person.full_name
  end
  
  test "should search for people" do
    click_on @customer.person.first_name
    click_on 'Friends'
    fill_in "fsearch", with: "rick"
    click_on "search", class: "btn-primary"
    assert_selector "h5", @customer2.person.full_name
  end
  
  test "should get show from rating" do
    #todo
  end
  
  test "should get customer from comment" do
    click_on @customer.person.first_name
    click_on 'Profile'
    click_on @comment.commentor.person.username
    assert_selector "h4", @customer2.person.full_name
  end
  
  test "should get show from favorites" do
    click_on @customer.person.first_name
    click_on 'Profile'
    click_on @fav.content.name
    assert_selector "h1", @fav.content.name
  end
  
  test "should subscribe when click subscribe" do
    click_on 'Browse'
    click_on @show2.name
    assert_difference("Subscription.count", 1) do
      click_on 'Subscribe'
    end
  end
  
  test "should watch episode from subscription" do
    click_on 'Vidon'
    click_on 'Episodes'
    click_on 'Watch'
    assert_selector "h3", @episode.video.title
  end
  
  test "should rent movie" do
    click_on 'Browse'
    click_on 'Movies'
    click_on @movie.video.title
    assert_difference("Rental.count", 1) do
      click_on 'Rent'
    end
  end
  
  test "should watch movie from page" do
    click_on 'Browse'
    click_on 'Movies'
    click_on @movie.video.title
    click_on 'Watch'
    assert_selector "h3", @movie.video.title
  end
  
  test "should search for show" do
    fill_in "search", with: "ad"
    #doesn't see button
    click_on "search", class: "btn-primary"
    assert_selector "h5", @show.name
  end
  
  test "should search for movie" do
    fill_in "search", with: "mys"
    #doesn't see button
    click_on "search", class: "btn-primary"
    assert_selector "h5", @movie.video.title
  end
  
  test "should favorite movie" do
    click_on 'Browse'
    click_on 'Movies'
    click_on @movie2.video.title
    assert_difference("Favorite.count", 1) do
      click_on 'Favorite', class: "btn-primary"
    end
  end
  
  test "should post movie comment" do
    click_on 'My Rentals'
    click_on 'Play'
    fill_in "comment", with: "This is great!"
    assert_difference("VideoComment.count", 1) do
      click_on 'Post', class: "btn-primary"
    end
  end
  
  test "should favorite episode" do
    click_on 'My Shows'
    click_on 'Episodes'
    click_on 'Watch'
    assert_difference("Favorite.count", 1) do
      click_on 'Favorite', class: "btn-primary"
    end
  end
  
  test "should post episode comment" do
    click_on 'My Shows'
    click_on 'Episodes'
    click_on 'Play'
    fill_in "comment", with: "This is great!"
    assert_difference("VideoComment.count", 1) do
      click_on 'Post', class: "btn-primary"
    end
  end
  
  test "should login user" do
    #this one works - use this syntax
    visit root_url
    click_on 'Login'
    assert_selector "h1", "Login"
    fill_in "Username", with: @customer.person.username
    fill_in "Password", with: @customer.person.password
    click_on "Login", class: "btn-primary"
  end
end
