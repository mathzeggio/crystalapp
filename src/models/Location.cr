require "./Resident"

class Location
    property id : String
    property name : String
    property dimension : String
    property type : String
    property residents : Array(Resident)
  
    def initialize(@id : String = "", @name : String = "", @dimension : String = "", @type : String = "", @residents : Array(Resident) = [] of Resident)
    end
  
    def self.from_json(json : JSON::Any)
      new(
        id: json["id"].to_s,
        name: json["name"].to_s,
        dimension: json["dimension"].to_s,
        type: json["type"].to_s,
        residents: Array(JSON::Any).from_json(json["residents"].to_json).map { |resident_json| Resident.from_json(resident_json)}
      )
    end

    def self.get_data(response_data : Location)
      residents = response_data.residents.map { |resident| Resident.get(resident)}
      json = {
        id: response_data.id,
        name: response_data.name,
        dimension: response_data.dimension,
        type: response_data.type,
        popularity: residents.sum { |obj| obj[:episode] }
      }
      json
    end

end
  