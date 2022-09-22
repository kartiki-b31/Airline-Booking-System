json.extract! flight, :id, :name, :flight_id, :source, :destination, :manufacturer, :class, :capacity, :status, :cost, :created_at, :updated_at
json.url flight_url(flight, format: :json)
