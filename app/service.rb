require 'sinatra/base'
require_relative 'models/init'

class NoteAPI < Sinatra::Base
  configure { set :show_exceptions, false }
  post '/notes' do
    note = Note.new(params[:note])
    note.save

    status 201

    { id: note.id }.to_json
  end

  get '/notes/:id' do
    note = Note.find(params[:id], params[:password])

    status 200

    note.as_json
  end

  error do
    status 404
    { error: 1 }.to_json
  end
end
