class Review < ApplicationRecord
  belongs_to :restaurants
  def self.search_reviews(city_id, cuisine_id, key)
    response = HTTParty.get("https://developers.zomato.com/api/v2.1/search?entity_id=#{city_id}&entity_type=city&cuisines=#{cuisine_id}",
      headers: { 'Accept' => 'application/JSON', 'user-key' => key })
    
    response.success? ? response : (raise response.response)
    
    first_three_cities = response['restaurants'][0..2].map do |city|
      city['restaurant']['R']['res_id']
    end
    
    final = []
    first_three_cities.map do |city|
      final << HTTParty.get("https://developers.zomato.com/api/v2.1/reviews?res_id=#{city}",
        headers: { 'Accept' => 'application/JSON', 'user-key' => key })
    end
    
    final
  end
end


