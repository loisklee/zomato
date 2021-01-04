# frozen_string_literal: true

module Api
  class ReviewsController < ApplicationController
    # before_action :validate_params, only: :index

    def index
      key = request.headers['user-key']
      city_id = params[:city_id]
      cuisine_id = params[:cuisine_id]
      # limit = params[:limit] || 3

      reviews = Review.search_reviews(city_id, cuisine_id, key)
      
      render json: reviews.to_json
    end

    private 

    def validate_params
      return render json: {error:  'Missing API key'}, status: 401 if key.empty?
      return render json: {error: 'Missing city ID'}, status: 400 if params[:city_id].empty?
      return render json: {rror: 'Missing cuisine ID'}, status: 400 if params[:cuisine_id].empty?
    end

  end
end


