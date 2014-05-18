module ApiHelpers
  include Rack::Test::Methods
  
  def app
    NoteAPI
  end

  def json
    JSON.parse(last_response.body)
  end
end
