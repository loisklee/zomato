class Cuisine < ApplicationRecord
  belongs_to :cities
  belongs_to :restaurants
end