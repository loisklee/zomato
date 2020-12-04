require 'httparty'
require 'json'

class CuisinesController < ApplicationController
  
  def index
    @key = request.headers["user-key"]
    response = HTTParty.get("https://developers.zomato.com/api/v2.1/cities?q=Princeton", headers: {"Accept" => "application/JSON", "user-key" => "#{@key}"}).to_s
    @parsed_response = JSON.parse(response)
    
    render :json => @parsed_response
  end

end
