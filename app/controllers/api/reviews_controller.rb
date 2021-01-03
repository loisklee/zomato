# frozen_string_literal: true

module Api
  class ReviewsController < ApplicationController
    def index
      @key = request.headers['user-key']

      return render json: 'Error: Missing API key', status: 401 if @key.empty?
      return render json: 'Error: Missing city ID', status: 400 if params[:city_id].empty?
      return render json: 'Error: Missing cuisine ID', status: 400 if params[:cuisine_id].empty?

      response = HTTParty.get("https://developers.zomato.com/api/v2.1/search?entity_id=#{params[:city_id]}&entity_type=city&cuisines=#{params[:cuisine_id]}",
                              headers: { 'Accept' => 'application/JSON', 'user-key' => @key.to_s })

      response.success? ? response : (raise response.response)

      first_three_cities = response['restaurants'][0..2].map do |city|
        city['restaurant']['R']['res_id']
      end

      final = []
      first_three_cities.map do |city|
        final << HTTParty.get("https://developers.zomato.com/api/v2.1/reviews?res_id=#{city}",
                              headers: { 'Accept' => 'application/JSON', 'user-key' => @key.to_s })
      end

      render json: final
    end
  end
end
