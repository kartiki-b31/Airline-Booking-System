json.extract! reservation, :id, :passengers, :res_id, :ticket_class, :amenities, :total_cost, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
