require 'spec_helper'

describe 'Note API' do
  let(:password){ 'password'}
  let(:body){ 'body'}
  let(:title){ 'title' }
  let(:note_data){
    {
      password: password, 
      body: body, 
      title: title
    } 
  }

  describe 'POST /notes' do
    before{ post('/notes', { note: note_data }) }

    it 'returns success' do
      expect(last_response.status).to eq(201)
      expect(json["id"]).to_not be_nil
    end
  end

  describe 'GET /notes/:api' do
    let(:id) do
      note = Note.new note_data 
      note.save and note.id
    end

    before{ get("/notes/#{id}", { password: password })}

    it 'returns success' do
      expect(last_response.status).to eq(200)
      expect(json["note"]["id"].to_i).to eq(id)
      expect(json["note"]["title"]).to eq(title)
      expect(json["note"]["body"]).to eq(body)
    end
  end
end