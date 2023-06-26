require "http/client"
require "./*"
require "json"

class QueryService

    def initialize()
        @url = "https://rickandmortyapi.com/graphql"
        @headers = HTTP::Headers{"Content-Type" => "application/json"}
    end
    

    def get_data(ids : Array(Int32), expand : Bool, optimize : Bool)
        query = "{\"query\":\"query GetAll {\\n  locationsByIds(ids: #{ids}) {\\n    id\\n    name\\n    dimension\\n  type\\n   residents {\\n      id\\n      episode {\\n        id\\n      }\\n    }\\n  }\\n}\\n\\n\"}"
        response = HTTP::Client.post(@url, headers: @headers, body: query)
        data = ApiFilterService.from_json(JSON.parse(response.body))
        if data
            ApiFilterService.get_data(data, expand, optimize)
        else
          "Erro na requisição"
        end
    end

end
