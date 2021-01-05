# frozen_string_literal: true

class Restaurant < ApplicationRecord
  belongs_to :cities

  has_many :reviews
  has_many :cuisines
end
