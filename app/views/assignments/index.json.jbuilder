json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :no, :reference, :text, :status_id, :duedate, :user_id, :comment
  json.url assignment_url(assignment, format: :json)
end
