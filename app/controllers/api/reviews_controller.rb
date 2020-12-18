class Api::ReviewsController < ApplicationController
  def index
    key = request.headers["user-key"]

    return render json: 'Error: Missing API key', status: 401 unless !key.empty?
    return render json: 'Error: Missing city ID', status: 400 unless !params[:city_id].empty?
    return render json: 'Error: Missing cuisine ID', status: 400 unless !params[:cuisine_id].empty?

    response = HTTParty.get("https://developers.zomato.com/api/v2.1/search?entity_id=#{params[:city_id]}&entity_type=city&cuisines=#{params[:cuisine_id]}", headers: {"Accept" => "application/JSON", "user-key" => "#{key}"})

    city_1 = response["restaurants"][0]["restaurant"]["R"]["res_id"]
    city_2 = response["restaurants"][1]["restaurant"]["R"]["res_id"]
    city_3 = response["restaurants"][2]["restaurant"]["R"]["res_id"]

    revres = HTTParty.get("https://developers.zomato.com/api/v2.1/reviews?res_id=#{city_1}", headers: {"Accept" => "application/JSON", "user-key" => "#{key}"})
    views1 =  revres["user_reviews"]

    revres2 = HTTParty.get("https://developers.zomato.com/api/v2.1/reviews?res_id=#{city_2}", headers: {"Accept" => "application/JSON", "user-key" => "#{key}"})
    views2 =  revres2["user_reviews"]

    revres3 = HTTParty.get("https://developers.zomato.com/api/v2.1/reviews?res_id=#{city_3}", headers: {"Accept" => "application/JSON", "user-key" => "#{key}"})
    views3 =  revres3["user_reviews"]

    final = (views1).concat(views2).concat(views3)

    render :json => final
  end
end