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
    breed.to_s.split(/\W/).map(&:downcase)
  end

  def random!
    DogAPIClient.fetch_random_image(search.join('/'))
  rescue RestClient::ExceptionWithResponse
    nil
  end

  private

  def breed_exists_in_api?
    return false if search.size > 2

    breed = search.first.to_s
    return false unless breeds.keys.include?(breed.downcase)
    return false unless search.size < 2 || breeds[breed.downcase].include?(search.last)

    true
  end

  def breed_exists_in_api
    errors.add(:breed, :invalid) unless breed_exists_in_api?
  end
end
