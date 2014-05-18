require 'json'

class Note
  class Serialization
    def self.serialize(note)
      note.to_json
    end

    def self.deserialize(note)
      JSON.parse(note)
    end
  end
end