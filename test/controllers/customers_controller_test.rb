require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
    @customer2 = customers(:two)
    @show = shows(:one)
    @show2 = shows(:two)
    @movie = movies(:one)
    @movie2 = movies(:two)
    @comment = profile_comments(:one)
    @fav = favorites(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  end

  test "should get index" do
    get customers_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_url
    assert_response :success
  end 

  test "should create customer" do
    assert_difference('Customer.count') do
      post customers_url, params: { customer: { person_attributes: { username: 
        "newuser", password: "123456", password_confirmation: "123456", email:
        "newuser@example.com", first_name: "New", last_name: "User" } } }
    end

    assert_redirected_to customer_url(Customer.last)
  end

  test "should show customer" do
    # get customer_url(@customer)
    # assert_response :success
  end

  test "should get edit" do
    log_in_as(@customer.person)
    get edit_customer_url(@customer)
    assert_response :success
  end

  test "should update customer" do
    patch customer_url(@customer), params: { customer: { person_attributes: {
      username: "newuser", password: "123456", password_confirmation: "123456",
      email: "newuser@example.com", first_name: "New", last_name: "User" } } }
    #assert_redirected_to customer_url(@customer)
  end

  test "should destroy customer" do
    log_in_as(@customer.person)
    assert_difference('Customer.count', -1) do
      delete customer_url(@customer)
    end

    assert_redirected_to customers_url
  end
  
  test "should get browse" do
    log_in_as(@customer.person)
    click_on 'Browse'
    assert_response :success
  end
  
  test "should get shows" do
    log_in_as(@customer.person)
    click_on 'My Shows'
    assert_redirected_to shows_url
  end
  
  test "should get rentals" do
    log_in_as(@customer.person)
    click_on 'My Rentals'
    assert_redirected_to my_rentals_url
  end
  
  test "should get friends" do
    log_in_as(@customer.person)
    click_on @customer.person.username
    click_on 'Friends'
    assert_redirected_to friends_url
  end
  
  test "should get profile" do
    log_in_as(@customer.person)
    click_on @customer.person.username
    click_on 'Profile'
    assert_redirected_to customer_url(@customer)
  end
  
  test "should get settings" do
    log_in_as(@customer.person)
    click_on @customer.person.username
    click_on 'Settings'
    assert_redirected_to edit_customer_path(@customer)
  end
  
  test "should log out" do
    log_in_as(@customer.person)
    click_on @customer.person.username
    click_on 'Log Out'
    assert_redirected_to root_url
  end
  
  test "should get subscription" do
    log_in_as(@customer.person)
    click_on 'My Shows'
    click_on 'Episodes'
    assert_redirected_to show_url(@show)
  end
  
  test "should get recommendation" do
    log_in_as(@customer.person)
  end
  
  test "should get recently updated" do
    log_in_as(@customer.person)
  end
  
  test "should get show from browse" do
    log_in_as(@customer.person)
    click_on 'Browse'
    click_on @show.name
    assert_redirected_to show_url(@show)
  end
  
  test "should get movie from browse" do
    log_in_as(@customer.person)
    click_on 'Browse'
    click_on 'Movies'
    click_on @movie.video.title
    assert_redirected_to movie_url(@movie)
  end
  
  test "should get movie tab" do
    log_in_as(@customer.person)
    click_on 'Browse'
    click_on 'Movies'
    assert_response :success
  end
  
  test "should cancel subscription" do
    log_in_as(@customer.person)
    click_on 'My Shows'
    click_on 'Cancel'
    find 'Renew'
  end
  
  test "should get browse from my shows" do
    log_in_as(@customer.person)
    click_on 'Find new shows!'
    assert_redirected_to browse_url
  end
  
  test "should get browse from rentals" do
    log_in_as(@customer.person)
    click_on 'My Rentals'
    click_on 'Find new movies!'
    assert_redirected_to browse_url
  end
  
  test "should play subscription" do
    log_in_as(@customer.person)
    click_on 'Episodes'
    click_on 'Play'
    assert_redirected_to show_video_url(@show.video)
  end
  
  test "should play rental" do
    log_in_as(@customer.person)
    click_on 'My Rentals'
    click_on 'Play'
    assert_redirected_to video_url(@movie.video)
  end
  
  test "should see friends" do
    log_in_as(@customer.person)
    click_on @customer.person.username
    click_on 'Friends'
    click_on @customer2.person.username
    assert_redirected_to customer_url(@customer2)
  end
  
  test "should search for people" do
    log_in_as(@customer.person)
    click_on @customer.person.username
    click_on 'Friends'
    click_on 'Search'
  end
  
  test "should get show from rating" do
    
  end
  
  test "should get customer from comment" do
    log_in_as(@customer.person)
    click_on @customer.person.username
    click_on 'Profile'
    click_on @comment.commentor.person.username
    assert_redirected_to customer_url(@customer2)
  end
  
  test "should get show from favorites" do
    log_in_as(@customer.person)
    click_on @customer.person.username
    click_on 'Profile'
    click_on @fav.content.name
    assert_redirected_to show_url(@show)
  end
  
  test "should subscribe when click subscribe" do
    log_in_as(@customer.person)
    click_on 'Browse'
    click_on @show2.name
    assert_difference("Subscription.count") do
      click_on 'Subscribe'
    end
  end
  
  test "should watch episode from subscription" do
    log_in_as(@customer.person)
    click_on 'Episodes'
    click_on 'Watch'
    assert_redirected_to video_url(@show.video)
  end
  
  test "should rent movie" do
    log_in_as(@customer.person)
    click_on 'Browse'
    click_on 'Movies'
    click_on @movie.video.title
    assert_difference("Rental.count") do
      click_on 'Rent'
    end
  end
  
  test "should watch movie from page" do
    log_in_as(@customer.person)
    click_on 'Browse'
    click_on 'Movies'
    click_on @movie.video.title
    click_on 'Watch'
    assert_redirected_to video_url(@movie.video)
  end
  
  test "should search for show" do
  end
  
  test "should favorite movie" do
    log_in_as(@customer.person)
    click_on 'Browse'
    click_on 'Movies'
    click_on @movie2.video.title
    assert_difference("Favorite.count") do
      click_on 'Favorite'
    end
  end
  
  test "should post movie comment" do
  end
  
  test "should favorite episode" do
    log_in_as(@customer.person)
    click_on 'Episodes'
    click_on 'Watch'
    assert_difference("Favorite.count") do
      click_on 'Favorite'
    end
  end
  
  test "should post episode comment" do
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
