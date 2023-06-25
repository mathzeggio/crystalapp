require "http/client"
require "../models/*"
require "json"

class RickNMortyApiService

    def initialize()
        @url = "https://rickandmortyapi.com/graphql"
        @headers = HTTP::Headers{"Content-Type" => "application/json"}
    end
    

    def get_data(ids : Array(Int32), expand : Bool, optimize : Bool)
        query = "{\"query\":\"query GetAll {\\n  locationsByIds(ids: #{ids}) {\\n    id\\n    name\\n    dimension\\n  type\\n   residents {\\n      id\\n      episode {\\n        id\\n      }\\n    }\\n  }\\n}\\n\\n\"}"
        response = HTTP::Client.post(@url, headers: @headers, body: query)
        data = ResponseData.from_json(JSON.parse(response.body))
        if data
            ResponseData.get_data(data, false, true).to_s
        else
          "Erro na requisição"
        end
    end

end
