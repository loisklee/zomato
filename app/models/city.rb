# frozen_string_literal: true

class City < ApplicationRecord
  has_many :cuisines
  has_many :restaurants 

  def self.get_info(city, key)
    response = HTTParty.get("https://developers.zomato.com/api/v2.1/cities?q=#{city}",
                            headers: { 'Accept' => 'application/JSON', 'user-key' => key })

    response.success? ? response : (raise response.response)

    city_id = response['location_suggestions'].first['id']
    city_info = response['location_suggestions'].first

    cuisine_list = City.get_cuisines(city_id, key)
    city_info.merge!({ cuisines: cuisine_list })
    city_info
  end

  def self.get_cuisines(city_id, key)
    response = HTTParty.get("https://developers.zomato.com/api/v2.1/cuisines?city_id=#{city_id}",
                            headers: { 'Accept' => 'application/JSON', 'user-key' => key })

    response['cuisines'].map do |cuisine|
      {
        name: cuisine['cuisine']['cuisine_name'],
        id: cuisine['cuisine']['cuisine_id']
      }
    end
  end
end
