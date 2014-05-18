require 'sinatra/base'
require_relative 'models/note'

Dir[File.dirname(__FILE__) + '/models/note/*.rb'].each {|file| require file }

class NoteAPI < Sinatra::Base
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
end
