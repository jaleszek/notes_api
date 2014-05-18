class Note
  attr_reader :body, :title, :id

  def initialize(args)
    assign_variables(args)
  end

  def save
    serialize_and_save_to_storage
  end

  def self.find(id, password)
    new look_for_and_deserialize(id, password)
  end

  private

  def serialize_and_save_to_storage
    note = Note::Serialization.serialize as_hash
    note = Note::Encryption.new(@password).encrypt(note)
    @id  = Note::Storage.new.write(note)
  end

  def self.look_for_and_deserialize(id, password)
    res = Note::Storage.new.read(id)
    res = Note::Encryption.new(password).decrypt(res)
    res = Note::Serialization.deserialize(res)
    res[:id] = id
    res
  end

  def as_hash
    {
      body: body,
      title: title
    }
  end

  def supported_input
    [:body, :title, :password, :id, 'body', 'title', 'password', 'id']
  end

  def assign_variables(args)
    supported_input.each do |key|
      instance_variable_set "@#{key}", args[key] if args[key]
    end
  end
end