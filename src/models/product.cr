class Product < Jennifer::Model::Base
  with_timestamps

  mapping(
    id: Primary32,
    name: String,
    price: Float64,
    created_at: Time?,
    updated_at: Time?,
  )
end
