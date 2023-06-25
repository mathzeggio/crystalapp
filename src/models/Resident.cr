require "./Episode"

class Resident
    property id : String
    property episode : Array(Episode)
  
    def initialize(@id : String = "", @episode : Array(Episode) = [] of Episode)
    end
  
    def self.from_json(json : JSON::Any)
      new(
        id: json["id"].to_s,
        episode: Array(JSON::Any).from_json(json["episode"].to_json).map { |episode| Episode.from_json(episode)}
      )
    end

    def self.get(response_data : Resident)
      json = {
        id: response_data.id,
        episode: response_data.episode.size
      }
      json
    end
end