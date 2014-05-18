require 'spec_helper'

describe Note do

  subject{described_class.new(args)}
  let(:args){ 
    {
      body: body, 
      password: password, 
      title: title
    }
  }

  let(:body){ 'body'}
  let(:title){ 'title'}
  let(:password){ 'password' }

  describe '.initialize' do
    it 'assigns arguments from input' do
      expect(subject.body).to eq(body)
      expect(subject.title).to eq(title)
    end
  end

  describe '#save' do
    before{ subject.save }
    it 'stores the id' do
      expect(subject.id).to be_a(Numeric)
    end

    it 'saves the Note' do
      obj = described_class.find(subject.id, password)
      expect(obj.id).to eq(subject.id)
      expect(obj.body).to eq(body)
      expect(obj.title).to eq(title)
    end
  end

  describe '.find' do
    let(:id){ 1 }

    it 'performs looking for a Note' do
      expect_any_instance_of(Note::Storage).to receive(:read).with(id)
      expect_any_instance_of(Note::Encryption).to receive(:decrypt)
      expect(Note::Serialization).to receive(:deserialize).and_return(args)

      note = described_class.find(id, password)

      expect(note.id).to eq(id)
    end
  end
end