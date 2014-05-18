require 'spec_helper'

describe Note::Storage do
  subject{ described_class.new(test_storage) }
  let(:test_storage){ "./test-storage"}
  let(:content){ "123123123213"}

  around{ clean_storage_directory test_storage }

  describe '#write' do
    it 'writes content' do
      expect(File).to receive(:write) do |path, content|
        expect(content).to eq(content)
      end
      subject.write(content)
    end

    it 'creates test directory' do
      expect(File.directory?(test_storage)).to be_false
      subject.write(content)
      expect(File.directory?(test_storage)).to be_true
    end

    it 'increments filename' do
      id = subject.write(content)
      expect(subject.write(content)).to eq(id + 1 )
    end
  end

  describe '#read' do
    it 'reads what wrote previously' do
      id = subject.write(content)
      expect(subject.read(id)).to eq(content)
    end
  end
end

def clean_storage_directory(dir)
  FileUtils.rm_rf(dir)
end