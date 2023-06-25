class Episode
    property id : String | Nil
  
    def initialize(@id : String | Nil = nil)
    end
  
    def self.from_json(json : JSON::Any)
      new(
        id: json["id"].to_s,
      )
    end

    def self.get(response_data : Episode)
      json = {
        id: response_data.id,
      }
      json
    end
  end
  