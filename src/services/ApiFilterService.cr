require "../models/Location"

class ApiFilterService
  property locationsByIds : Array(Location)

  def initialize(@locationsByIds : Array(Location) = [] of Location)
  end
  
  def self.from_json(json : JSON::Any)
    locations = Array(JSON::Any).from_json(json["data"]["locationsByIds"].to_json).map { |location| Location.from_json(location) }
    new(locations)
  end

  def self.get_data(response_data : ApiFilterService, expand : Bool, optimize : Bool)
    dataArray = response_data.locationsByIds.map { |location| Location.get_data(location)}
    if optimize
      optimizedArray = self.optimize_filters(dataArray)
      if expand
        self.expand(optimizedArray)
      else
        optimizedArray.map { |obj| obj["id"].to_i}
      end
    else
      self.expand(dataArray)
    end
  end

  def self.expand(data_array : Array(NamedTuple))
    expandedArray = data_array.map do |object|
      newObject = {
        id: object["id"].to_i,
        name: object["name"],
        dimension: object["dimension"],
        type: object["type"]
      }
      newObject
    end    
    expandedArray
  end

  def self.optimize_filters(data_array : Array(NamedTuple))
    groupedHash = data_array.group_by { |item| item[:dimension] }  
    dimension_popularity = Hash(String, Float64).new
    
    groupedHash.each do |dimension, objects|
      dimension_popularity[dimension] = objects.sum { |obj| obj[:popularity] } / objects.size
    end

    sorted_dimensions = dimension_popularity.to_a.sort_by { |_, popularity| popularity }.to_h
    orderedObjects = sorted_dimensions.flat_map { |dimension, _| groupedHash[dimension] }
    groupedObjects = orderedObjects.group_by { |item| item["dimension"] }

    groupedObjects.each do |dimension, objects|
      objects.sort_by! { |item| item["popularity"].to_f }
      objects.sort! { |a, b| a["popularity"] == b["popularity"] ? a["name"] <=> b["name"] : 0 }
    end

    groupedObjects.values.flatten
  end

end