json.array!(@assignment_updates) do |assignment_update|
  json.extract! assignment_update, :id, :update_text
  json.url assignment_update_url(assignment_update, format: :json)
end
