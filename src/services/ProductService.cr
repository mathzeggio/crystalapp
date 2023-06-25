require "jennifer"
require "../models/*"

class TravelPlanService

    def create_travel(stops : Array(Int32)) #: TravelPlans
        travel_plan = TravelPlans.new({travel_stops: stops}, true)
        travel_plan.save
        TravelPlans.to_object(travel_plan)
    end

    def get_travel(id : Int32)
        TravelPlans.find!(id)
    end

    def get_travels(expand : Bool, optimize : Bool)
        TravelPlans.all
    end

    def update_travel(id : Int32, stops : Array(Int32))
        travel = get_travel(id)
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