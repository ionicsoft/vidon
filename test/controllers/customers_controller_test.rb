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
    @fav2 = favorites(:three)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  end

  #Start coverage testing
  test "should get index" do
    log_in_as(@customer.person)
    get customers_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@customer.person)
    get new_customer_url
    assert_response :success
  end 

  test "should create customer" do
    #does not create customer
    assert_difference('Customer.count', 1) do
      post customers_url, params: { customer: { person_attributes: { username: 
        "newuser", password: "123456", password_confirmation: "123456", email:
        "newuser@example.com", first_name: "New", last_name: "User" },
        payment_attributes: { card_name: "guy", card_num: "1234123412341234",
        cvc: 321, expiration: Date.today + 5.days}} }
    end

    assert_redirected_to customer_url(Customer.last)
  end

  test "should show customer" do
    log_in_as(@customer.person)
    get customer_url(@customer)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@customer.person)
    get edit_customer_url(@customer)
    #assert_response :redirect
    assert_response :success
  end

  test "should update customer" do
    log_in_as(@customer.person)
    patch customer_url(@customer), params: { customer: { person_attributes: {
      username: "newuser", password: "123456", password_confirmation: "123456",
      email: "newuser@example.com", first_name: "New", last_name: "User" } } }
    #assert_redirected_to customer_url(@customer)
  end

  test "should destroy customer" do
    #does not destroy customer
    log_in_as(@customer.person)
    assert_difference('Customer.count', -1) do
      delete customer_url(@customer)
    end

    assert_redirected_to customers_url
  end
  
  #Start use cases
  test "should get browse" do
    log_in_as_customer
    click_on 'Browse'
    assert_selector "a", "Shows"
  end
  
  test "should get shows" do
    log_in_as_customer
    click_on 'My Shows'
    assert_selector "h3", "My Shows"
  end
  
  test "should get rentals" do
    log_in_as_customer
    click_on 'My Rentals'
    assert_selector "h3", "My Rentals"
  end
  
  test "should get friends" do
    log_in_as_customer
    click_on @customer.person.first_name
    click_on 'Friends'
    assert_selector "h3", "Your friends"
  end
  
  test "should get profile" do
    log_in_as_customer
    click_on @customer.person.first_name
    click_on 'Profile'
    assert_selector "h4", @customer.person.full_name
  end
  
  test "should get settings" do
    log_in_as_customer
    click_on @customer.person.first_name
    click_on 'Settings'
    assert_selector "h1", "Edit Information"
  end
  
  test "should log out" do
    log_in_as_customer
    click_on @customer.person.first_name
    click_on 'Log out'
    assert_selector "h2", "Say hello to subscriptions."
  end
  
  test "should get subscription" do
    log_in_as_customer
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
    log_in_as_customer
    click_on 'Browse'
    click_on @show.name
    assert_selector "h1", @show.name
  end
  
  test "should get movie from browse" do
    log_in_as_customer
    click_on 'Browse'
    click_on 'Movies'
    click_on @movie.video.title
    assert_selector "h1", @movie.video.title
  end
  
  test "should get movie tab" do
    log_in_as_customer
    click_on 'Browse'
    click_on 'Movies'
    assert_selector "h5", @movie.video.title
  end
  
  test "should cancel subscription" do
    log_in_as_customer
    click_on 'My Shows'
    click_on 'Cancel'
    assert_selector "input", "Renew"
  end
  
  test "should get browse from my shows" do
    log_in_as_customer
    click_on 'My Shows'
    click_on 'Find new shows!'
    assert_selector "a", "Shows"
  end
  
  test "should get browse from rentals" do
    log_in_as_customer
    click_on 'My Rentals'
    click_on 'Find new movies!'
    assert_selector "a", "Shows"
  end
  
  test "should play subscription" do
    log_in_as_customer
    click_on 'My Shows'
    click_on 'Episodes'
    first(:link, 'Play').click
    assert_selector "h5", @show.name
  end
  
  test "should play rental" do
    log_in_as_customer
    click_on 'My Rentals'
    click_on 'Play'
    assert_selector "h3", @movie.video.title
  end
  
  test "should see friends" do
    log_in_as_customer
    click_on @customer.person.first_name
    click_on 'Friends'
    assert_selector "h4", @customer2.person.full_name
  end
  
  test "should get friend's page" do
    log_in_as_customer
    click_on @customer.person.first_name
    click_on 'Friends'
    click_on @customer2.person.full_name
    assert_selector "h4", @customer2.person.full_name
  end
  
  test "should search for people" do
    log_in_as_customer
    click_on @customer.person.first_name
    click_on 'Friends'
    fill_in "fsearch", with: "rick"
    click_on 'friend_search'
    assert_selector "h5", @customer2.person.full_name
  end
  
  test "should get show from rating" do
    #todo
  end
  
  test "should get customer from comment" do
    log_in_as_customer
    click_on @customer.person.first_name
    click_on 'Profile'
    click_on @comment.commentor.person.full_name
    assert_selector "h4", @customer2.person.full_name
  end
  
  test "should get movie from favorites" do
    log_in_as_customer
    click_on @customer.person.first_name
    click_on 'Profile'
    click_on @fav.content.video.title
    assert_selector "h4", @fav.content.video.title
  end
  
  test "should get episode from favorites" do
    log_in_as_customer
    click_on @customer.person.first_name
    click_on 'Profile'
    click_on @fav2.content.video.title
    assert_selector "h4", @fav2.content.video.title
  end
  
  test "should subscribe when click subscribe" do
    log_in_as_customer
    click_on 'Browse'
    click_on @show2.name
    assert_difference("Subscription.count", 1) do
      first(:button, 'Subscribe').click
      click_on "Subscribe", class: "btn-primary"
    end
  end
  
  test "should watch episode from subscription" do
    log_in_as_customer
    click_on 'My Shows'
    click_on 'Episodes'
    click_on 'Watch'
    assert_selector "h3", @episode.video.title
  end
  
  test "should rent movie" do
    log_in_as_customer
    click_on 'Browse'
    click_on 'Movies'
    click_on @movie2.video.title
    assert_difference("Rental.count", 1) do
      click_on 'Rent'
    end
  end
  
  test "should watch movie from page" do
    log_in_as_customer
    click_on 'Browse'
    click_on 'Movies'
    click_on @movie.video.title
    click_on 'Watch'
    assert_selector "h3", @movie.video.title
  end
  
  test "should search for show" do
    log_in_as_customer
    fill_in "search", with: "ad"
    click_on "search-btn"
    assert_selector "h5", @show.name
  end
  
  test "should search for movie" do
    log_in_as_customer
    fill_in "search", with: "mys"
    click_on "search-btn"
    assert_selector "h5", @movie.video.title
  end
  
  test "should favorite movie" do
    log_in_as_customer
    click_on 'My Rentals'
    click_on 'Play'
    assert_difference("Favorite.count", 1) do
      click_on 'Favorite', class: "btn-primary"
    end
  end
  
  test "should post movie comment" do
    log_in_as_customer
    click_on 'My Rentals'
    first(:link, 'Play').click
    fill_in "video_comment_comment", with: "This is great!"
    assert_difference("VideoComment.count", 1) do
      click_on 'Post', class: "btn-primary"
    end
  end
  
  test "should favorite episode" do
    log_in_as_customer
    click_on 'My Shows'
    click_on 'Episodes'
    click_on 'Watch'
    click_on 'button_next'
    assert_difference("Favorite.count", 1) do
      click_on 'Favorite', class: "btn-primary"
    end
  end
  
  test "should post episode comment" do
    log_in_as_customer
    click_on 'My Shows'
    click_on 'Episodes'
    first(:link, 'Play').click
    fill_in "video_comment_comment", with: "This is great!"
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
