# frozen_string_literal: true

module Api
  class CuisinesController < ApplicationController
    def index
      key = request.headers['user-key']
      city = params[:city]

      cuisines = City.get_info(city, key)
      render json: cuisines
    end

    # private

    # def validate_params
    #   return render json: 'Error: Missing API key', status: 401 if key.empty?
    #   return render json: 'Error: Missing city query', status: 400 if params[:city].empty?
    # end

  end
end
