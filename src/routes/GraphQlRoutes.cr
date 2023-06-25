
require "../services/*"

api_service = RickNMortyApiService.new

get "/graphql" do |env|
    test = api_service.get_data([2,7,9,11,19], true, true)
    env.response.content_type = "application/json"
    test
end
