json.array!(@assignment_statuses) do |assignment_status|
  json.extract! assignment_status, :id, :status
  json.url assignment_status_url(assignment_status, format: :json)
end
