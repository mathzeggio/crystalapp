require "kemal"
require "../services/*"

travel_plans_service = TravelPlanService.new

get "/travel-plans/:id" do |env|
  env.response.content_type = "application/json"
  travel_plans_service.get_travel(env.params.url["id"].to_i.to_i32).to_json
end

get "/travel-plans" do |env|
  expand = env.request.headers["expand"].to_s.downcase == "true"
  optimize = env.request.headers["optimize"].to_s.downcase == "true"

  travel_plans = travel_plans_service.get_travels(expand, optimize).to_json
  env.response.content_type = "application/json"
  travel_plans
end

post "/travel-plans" do |env|
  request_body = env.params.json["travel_stops"].as(Array(JSON::Any))
  env.response.content_type = "application/json"
  travel_stops = request_body.map { |stop| stop.to_s.to_i32 }

  travel_plans = travel_plans_service.create_travel(travel_stops)

  if travel_plans
    env.response.status_code = 201
    travel_plans.to_s
  else 
    "Erro"
  end
end

put "/travel-plans/:id" do |env|
  id = env.params.url["id"].to_i.to_i32
  request_body = env.params.json["travel_stops"].as(Array(JSON::Any))
  env.response.content_type = "application/json"
  travel_stops = request_body.map { |stop| stop.to_s.to_i32 }
  updated_travel = travel_plans_service.update_travel(id, travel_stops)
  if updated_travel
    updated_travel.to_s
  else 
    "Erro ao atualizar"
  end
end

delete "/travel-plans/:id" do |env|
  travel_plans_service.delete_travel(env.params.url["id"].to_i.to_i32)
  env.response.status_code = 204
end