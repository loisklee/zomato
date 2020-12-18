class Api::CuisinesController < ApplicationController
  def index
    key = request.headers["user-key"]

    return render json: 'Error: Missing API key', status: 401 unless !key.empty?
    return render json: 'Error: Missing city query', status: 400 unless !params[:city].empty?

    response = HTTParty.get("https://developers.zomato.com/api/v2.1/cities?q=#{params[:city]}", headers: {"Accept" => "application/JSON", "user-key" => "#{key}"})
    
    city_id = response["location_suggestions"][0]["id"]
    city_info = response["location_suggestions"][0]

    sec_response = HTTParty.get("https://developers.zomato.com/api/v2.1/cuisines?city_id=#{city_id}", headers: {"Accept" => "application/JSON", "user-key" => "#{key}"})

    city_info['cuisines'] = sec_response["cuisines"].map do |cuisine|
      {
        name: cuisine['cuisine']['cuisine_name'],
        id: cuisine['cuisine']['cuisine_id']
      }
    end

    render :json => city_info
  end
end
