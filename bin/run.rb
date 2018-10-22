require_relative '../config/environment'

def yelp_api_request(url)
  # binding.pry
  JSON.parse(RestClient.get("#{url}", :Authorization => "Bearer ZCGB7cghN6Tbki6ojzII7FrWTpKUxQ3FRxvxjOG1YSBFZg7LS8TULAO6gQtFodUK1ku8xcImJBqvAlqS1uAN_zhmXxyH2TYb7qHhSrB77GASx8wH_WRJOrDMCzDOW3Yx"))
end


puts "HELLO WORLD"
