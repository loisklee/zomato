require 'httparty'
require 'json'

class Api::CuisinesController < ApplicationController
  def index
    key = request.headers["user-key"]
    response = JSON.parse(HTTParty.get("https://developers.zomato.com/api/v2.1/cities?q=#{params[:city]}", headers: {"Accept" => "application/JSON", "user-key" => "#{key}"}).to_s)
    
    return render json: 'Error: Missing API key', status: 401 unless key
    return render json: 'Error: Missing city query', status: 400 unless params[:city]

    city_id = response["location_suggestions"][0]["id"]
    city_info = response["location_suggestions"][0]

    sec_response = JSON.parse(HTTParty.get("https://developers.zomato.com/api/v2.1/cuisines?city_id=#{city_id}", headers: {"Accept" => "application/JSON", "user-key" => "#{key}"}).to_s)

    result = JSON.dump((city_info).merge(sec_response))

    render :json => result
  end
end
