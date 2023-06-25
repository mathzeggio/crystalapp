class CreateTravelPlans < Jennifer::Migration::Base
  def up
    create_table :travel_plans do |t|
      t.integer :id , {:null => false, :auto_increment => true}
      t.integer :travel_stops, {:null => false, :array => true}
    end
  end

  def down
    drop_table :travel_plans if table_exists? :TravelPlans
  end
end
