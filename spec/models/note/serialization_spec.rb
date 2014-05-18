require 'spec_helper'

describe Note::Serialization do
  subject{ described_class }

  let(:note){ {'title' => 'title', 'body' => 'body', 'id'=> 'id'}}

  describe 'serialization' do
    it 'handles with serialization' do
      serialized = subject.serialize(note)

      deserialized = subject.deserialize(serialized)
      expect(deserialized).to eq(note)
    end
  end
end
