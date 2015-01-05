json.array!(@courses) do |course|
  json.extract! course, :id, :name, :category, :year, :grade, :teacher, :note
  json.url course_url(course, format: :json)
end
