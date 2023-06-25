class TravelPlans < Jennifer::Model::Base
    mapping(
      id: Primary32,
      travel_stops: {type: Array(Int32), default: [] of Int32}
    )

    def self.to_object(travel_plans : TravelPlans)
        json = {
            id: travel_plans.id,
            travel_stops: travel_plans.travel_stops
        }
        json
    end

end
  