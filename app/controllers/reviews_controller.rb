class ReviewsController < ApplicationController
  
  def index
    key = request.headers["user-key"]
    response = JSON.parse(HTTParty.get("https://developers.zomato.com/api/v2.1/search?entity_id=#{params[:city_id]}&entity_type=city&cuisines=#{params[:cuisine_id]}", headers: {"Accept" => "application/JSON", "user-key" => "#{key}"}).to_s)

    return render json: 'Error: Missing API key', status: 401 unless key
    return render json: 'Error: Missing city ID and/or cuisine ID', status: 400 if !params[:city_id] || !params[:cuisine_id]

    city_1 = response["restaurants"][0]["restaurant"]["R"]["res_id"]
    city_2 = response["restaurants"][1]["restaurant"]["R"]["res_id"]
    city_3 = response["restaurants"][2]["restaurant"]["R"]["res_id"]

    revres = JSON.parse(HTTParty.get("https://developers.zomato.com/api/v2.1/reviews?res_id=#{city_1}", headers: {"Accept" => "application/JSON", "user-key" => "#{key}"}).to_s)
    views1 =  revres["user_reviews"]

    revres2 = JSON.parse(HTTParty.get("https://developers.zomato.com/api/v2.1/reviews?res_id=#{city_2}", headers: {"Accept" => "application/JSON", "user-key" => "#{key}"}).to_s)
    views2 =  revres2["user_reviews"]

    revres3 = JSON.parse(HTTParty.get("https://developers.zomato.com/api/v2.1/reviews?res_id=#{city_3}", headers: {"Accept" => "application/JSON", "user-key" => "#{key}"}).to_s)
    views3 =  revres3["user_reviews"]

    final = (views1).concat(views2).concat(views3)

    render :json => final

  end
end
