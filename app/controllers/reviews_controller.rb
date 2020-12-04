class ReviewsController < ApplicationController
  
  def index
    @key = request.headers["user-key"]
    response = HTTParty.get("https://developers.zomato.com/api/v2.1/search?entity_id=#{params[:city_id]}&entity_type=city&cuisines=#{params[:cuisine_id]}", headers: {"Accept" => "application/JSON", "user-key" => "#{@key}"}).to_s

    @parsed_response = JSON.parse(response)
    city_1 = @parsed_response["restaurants"][0]["restaurant"]["R"]["res_id"]
    city_2 = @parsed_response["restaurants"][1]["restaurant"]["R"]["res_id"]
    city_3 = @parsed_response["restaurants"][2]["restaurant"]["R"]["res_id"]

    revres = HTTParty.get("https://developers.zomato.com/api/v2.1/reviews?res_id=#{city_1}", headers: {"Accept" => "application/JSON", "user-key" => "#{@key}"}).to_s
    @rev = JSON.parse(revres)
    @views1 =  @rev["user_reviews"]

    revres2 = HTTParty.get("https://developers.zomato.com/api/v2.1/reviews?res_id=#{city_2}", headers: {"Accept" => "application/JSON", "user-key" => "#{@key}"}).to_s
    @rev2 = JSON.parse(revres2)
    @views2 =  @rev2["user_reviews"]

    revres3 = HTTParty.get("https://developers.zomato.com/api/v2.1/reviews?res_id=#{city_3}", headers: {"Accept" => "application/JSON", "user-key" => "#{@key}"}).to_s
    @rev3 = JSON.parse(revres3)
    @views3 =  @rev3["user_reviews"]

    render :json => @views3

  end
end
