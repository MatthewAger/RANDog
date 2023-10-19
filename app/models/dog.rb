# frozen_string_literal: true

class Dog
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :breed, :string
  attribute :url, :string

  validate :breed_exists_in_api

  class << self
    def breeds
      DogAPIClient.fetch_all_breeds
    end
  end

  def breeds
    @breeds ||= self.class.breeds
  end

  def search
    return [] unless breed.present?

    @search ||=
      begin
        terms = breed.to_s.split(/\W/).reject(&:empty?).first(2).map(&:downcase)
        terms.reverse! unless dig?(terms.first, terms.second)
        terms
      end
  end

  def random!
    DogAPIClient.fetch_random_image(search.join('/'))
  rescue RestClient::ExceptionWithResponse
    nil
  end

  private

  def breed_exists_in_api?
    return false if search.size > 2

    breed, sub_breed = search
    return false unless dig?(breed, sub_breed) || dig?(sub_breed, breed)

    true
  end

  def dig?(breed, sub_breed = nil)
    breeds.key?(breed) && (sub_breed.blank? || breeds[breed].include?(sub_breed))
  end

  def breed_exists_in_api
    errors.add(:breed, :invalid) unless search.present? && breed_exists_in_api?
  end
end
