class Api::CuisinesController < ApplicationController
  def index
    key = request.headers["user-key"]

    return render json: 'Error: Missing API key', status: 401 if key.empty?
    return render json: 'Error: Missing city query', status: 400 if params[:city].empty?

    response = HTTParty.get("https://developers.zomato.com/api/v2.1/cities?q=#{params[:city]}", 
      headers: {"Accept" => "application/JSON", "user-key" => "#{key}"})
    
    city_id = response["location_suggestions"].first["id"]
    city_info = response["location_suggestions"].first

    sec_response = HTTParty.get("https://developers.zomato.com/api/v2.1/cuisines?city_id=#{city_id}", 
      headers: {"Accept" => "application/JSON", "user-key" => "#{key}"})

    city_info['cuisines'] = sec_response["cuisines"].map do |cuisine|
      {
        name: cuisine['cuisine']['cuisine_name'],
        id: cuisine['cuisine']['cuisine_id']
      }
    end

    render :json => city_info
  end
end
