# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dog, type: :model do
  subject { build :dog, breed: 'Border Collie' }

  describe '#breeds', :vcr do
    it 'returns a hash of breeds' do
      expect(described_class.breeds).to be_a(Hash)
    end
  end

  describe '#search', :vcr do
    it 'returns an array of search terms in order breed -> sub breed' do
      expect(subject.search).to eq(%w[collie border])
    end

    context 'when the breed is blank' do
      subject { build :dog, breed: nil }

      it 'returns an empty array' do
        expect(subject.search).to eq([])
      end
    end

    context 'when the breed contains non-word characters' do
      subject { build :dog, breed: 'Border-Collie' }

      it 'returns an array of search terms in order breed -> sub breed' do
        expect(subject.search).to eq(%w[collie border])
      end
    end

    context 'when the breed contains more than two words' do
      subject { build :dog, breed: 'Border Collie Mix' }

      it 'ignores the rest' do
        expect(subject.search).to eq(%w[collie border])
      end
    end
  end

  describe '#random!', :vcr do
    it 'returns a url' do
      expect(subject.random!).to be_a(String)
    end

    context 'when the breed is blank' do
      subject { build :dog, breed: nil }

      it 'returns nil' do
        expect(subject.random!).to be_nil
      end
    end

    context 'when the breed is invalid' do
      subject { build :dog, breed: 'Invalid Breed' }

      it 'returns nil' do
        expect(subject.random!).to be_nil
      end
    end
  end

  describe 'validations', :vcr do
    it 'is valid' do
      expect(subject).to be_valid
    end

    context 'when the breed is blank' do
      subject { build :dog, breed: nil }

      it 'is invalid' do
        expect(subject).to be_invalid
      end
    end

    context 'when the breed is invalid' do
      subject { build :dog, breed: 'Invalid Breed' }

      it 'is invalid' do
        expect(subject).to be_invalid
      end
    end

    context 'when the breed is valid' do
      subject { build :dog, breed: 'Border Collie' }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end
  end
end
