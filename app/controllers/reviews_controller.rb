class ReviewsController < ApplicationController
  
  def index
    @key = request.headers["user-key"]
    response = HTTParty.get("https://developers.zomato.com/api/v2.1/search?entity_id=280&entity_type=city&cuisines=25", headers: {"Accept" => "application/JSON", "user-key" => "#{@key}"}).to_s

    @parsed_response = JSON.parse(response)
    render :json => @parsed_response

  end
end
