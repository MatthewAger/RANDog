# frozen_string_literal: true

class DogAPIClient
  BASE_URL = 'https://dog.ceo/api'

  def self.fetch_random_image(breed)
    return nil unless breed.present?

    response = RestClient.get "#{BASE_URL}/breed/#{breed}/images/random"
    JSON.parse(response.body)['message']
  end

  def self.fetch_all_breeds
    response = RestClient.get "#{BASE_URL}/breeds/list/all"
    JSON.parse(response.body)['message']
  end
end
