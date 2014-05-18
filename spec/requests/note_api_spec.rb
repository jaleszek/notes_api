require 'spec_helper'

describe 'Note API' do
  describe 'POST /notes' do
    before{ post('/notes', {note: { password: '12345', body: 'abc', title: 'abc'}}) }

    it 'returns success' do
      expect(last_response.status).to eq(201)
      expect(json["id"]).to_not be_nil
    end
  end

  describe 'GET /notes/:api' do
    let(:password){ '00000999'}
    let(:body){ 'ased'}
    let(:title){ 'asdasdsad' }
    let(:id){ note = Note.new(body: body, password: password, title: title); note.save; note.id }

    before{ get("/notes/#{id}", {password: password})}

    it 'returns success' do
      expect(last_response.status).to eq(200)
      expect(json["note"]["id"].to_i).to eq(id)
      expect(json["note"]["title"]).to eq(title)
      expect(json["note"]["body"]).to eq(body)
    end
  end
end