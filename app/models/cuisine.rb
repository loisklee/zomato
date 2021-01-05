# frozen_string_literal: true

class Cuisine < ApplicationRecord
  belongs_to :cities
  belongs_to :restaurants
end
