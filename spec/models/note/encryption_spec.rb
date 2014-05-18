require 'spec_helper'

describe Note::Encryption do

  subject{described_class.new(current_password)}

  let(:content){ 'asdasdasd' }
  let(:password){'12345'}
  let(:encrypted){ "jy\xDA\x9D\a\x8F\xFF\xF3*\x8F[MFv\xC2M" }

  describe '#decrypt' do
    context 'good password' do
      let(:current_password){ password }
      it 'reads encrypted content' do
        expect(subject.decrypt(encrypted)).to eq(content)
      end
    end

    context 'wrong password' do
      let(:current_password){ '123' }
      it 'raises exception' do
        expect{subject.decrypt(encrypted)}.to raise_error(OpenSSL::Cipher::CipherError)
      end
    end
  end

  describe '#encrypt' do
    let(:current_password){ password }
    it 'generates proper encryption' do
      expect(subject.decrypt(encrypted)).to eq(content)
    end
  end
end