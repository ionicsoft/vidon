require 'test_helper'

class RentalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
    @movie = movies(:two)
    log_in_as(@customer.person)
  end

  test "should create rental" do
    assert_difference('Rental.count', 1) do
      post "#{url_for @movie}/rent", params: { rental: { movie_id: @movie.id, customer_id: @customer.id}}, headers: { 'HTTP_REFERER' => @movie }
    end
  end
end
