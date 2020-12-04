class ReviewsController < ApplicationController
  
  def index
    @key = request.headers["user-key"]
    response = HTTParty.get("https://developers.zomato.com/api/v2.1/search?entity_id=280&entity_type=city&cuisines=25", headers: {"Accept" => "application/JSON", "user-key" => "#{@key}"}).to_s

    @parsed_response = JSON.parse(response)
    city_1 = @parsed_response["restaurants"][0]["restaurant"]["R"]["res_id"]
    city_2 = @parsed_response["restaurants"][1]["restaurant"]["R"]["res_id"]
    city_3 = @parsed_response["restaurants"][2]["restaurant"]["R"]["res_id"]

    revres = HTTParty.get("https://developers.zomato.com/api/v2.1/reviews?res_id=#{city_1}", headers: {"Accept" => "application/JSON", "user-key" => "#{@key}"}).to_s
    @rev = JSON.parse(revres)
    @views1 =  @rev["user_reviews"]



    render :json => @views1

  end
end
