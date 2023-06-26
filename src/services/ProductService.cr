require "jennifer"
require "../models/*"


class TravelPlanService
    def initialize()
        @api_service = RickNMortyApiService.new
    end

    def create_travel(stops : Array(Int32))
        travel_plan = TravelPlans.new({travel_stops: stops}, true)
        travel_plan.save
        TravelPlans.to_object(travel_plan)
    end

    def get_travel(id : Int32, expand : Bool, optimize : Bool)
        travel =TravelPlans.find!(id)

        if expand || optimize
            json = {
                id: id,
                travel_stops:  @api_service.get_data(travel.travel_stops, expand, optimize)
            }
            json
        else
            travel
        end
    end

    def get_travels(expand : Bool, optimize : Bool)
        travels = TravelPlans.all()
        if expand || optimize
            travels = Array(JSON::Any).from_json(travels.to_json).map do |travel| 
                json = {
                    id: travel["id"],
                    travel_stops:  @api_service.get_data(Array(Int32).from_json(travel["travel_stops"].to_json), expand, optimize)
                }
                json
            end 
        else
            travels
        end

    end

    def update_travel(id : Int32, stops : Array(Int32))
        travel = TravelPlans.find!(id)
        if travel
            travel.travel_stops = stops
            travel.save
            TravelPlans.to_object(travel)
        else 
          "Não foi possivel encontrar produto com esse id"
        end
    end
      
    def delete_travel(id : Int32)
        TravelPlans.delete(id)
    end
end