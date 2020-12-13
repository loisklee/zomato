# iSeatz - P1 // Zomato API project

## Overview 

- **Endpoint 1**: /cuisines?city={:city_name}

  - Receives: a city name string (in Params) and a personal API key (in Headers)
  - Response: an object with city info and list of cuisines in that city

  - Example with :city_name being "New Orleans": 

    ```json
      {
      "id": 290,
      "name": "New Orleans, LA",
      "country_id": 216,
      "country_name": "United States",
      "country_flag_url": "https://b.zmtcdn.com/images/countries/flags/country_216.png",
      "should_experiment_with": 0,
      "has_go_out_tab": 0,
      "discovery_enabled": 1,
      "has_new_ad_format": 0,
      "is_state": 0,
      "state_id": 86,
      "state_name": "Louisiana",
      "state_code": "LA",
      "cuisines": [
        {
          "name": "Afghan",
          "id": 1035
        }
      ]
    }
    ```

- **Endpoint 2**: /reviews?city_id={:city_id}&cuisine_id={:cuisine_id}

  - Receives: city ID and cuisine ID (in Params) and a personal API key (in Headers)
  - Response: an array of reviews for the three returned restaurants for requested city (five each, fifteen in total)

  - Example with :city_id being "290" (New Orleans) and :cuisine_id being "25" (Chinese)

    ```json
    [
      {
        "review": {
            "rating": 4,
            "review_text": "my sunday night pickup for many years. crunchy peppered beef, veggie fried rice, generals chicken are my go to dishes. professional to the Nth degree. on time, hot, consistent, great flavors. ask for red pepper sauce for an extra kick. cant miss pick up",
            "id": 35949638,
            "rating_color": "5BA829",
            "review_time_friendly": "Jun 05, 2018",
            "rating_text": "Great!",
            "timestamp": 1528158976,
            "likes": 1,
            "user": {
                "name": "2eggsovereasywithgrits",
                "foodie_level": "Super Foodie",
                "foodie_level_num": 9,
                "foodie_color": "f58552",
                "profile_url": "https://www.zomato.com/users/2eggsovereasywithgrits-23581250?utm_source=api_basic_user&utm_medium=api&utm_campaign=v2.1",
                "profile_image": "https://b.zmtcdn.com/images/user_avatars/pizza_2x.png?fit=around%7C200%3A200&crop=200%3A200%3B%2A%2C%2A",
                "profile_deeplink": "zomato://u/23581250"
            },
            "comments_count": 0
        } 
          }
        ]
      }
    ]
    ```

## Usage - Local

## Built With
- Ruby on Rails
- HTTParty Gem

## Author

Lois K. Lee