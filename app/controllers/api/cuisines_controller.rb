# frozen_string_literal: true

module Api
  class CuisinesController < ApplicationController
    before_action :validate_params, only: :index

    def index
      key = request.headers['user-key']
      city = params[:city]

      cuisines = City.get_info(city, key)
      render json: cuisines
    end

    private

    def validate_params
      key = request.headers['user-key']
      city = params[:city]

      return render json: 'Error: Missing API key', status: 401 if key.empty? || key.nil?
      return render json: 'Error: Missing city query', status: 400 if city.nil? || city.empty?
    end
  end
end
