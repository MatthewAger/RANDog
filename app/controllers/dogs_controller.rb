# frozen_string_literal: true

class DogsController < ApplicationController
  before_action :fetch!, only: %i[show create]

  def index; end

  def show; end

  def create
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'dog',
          partial: 'dogs/dog',
          locals:  { dog: }
        )
      end

      format.html { redirect_to dog_url(dog.search) }
    end
  end

  private

  def dog
    @dog ||= Dog.new(breed: params[:breed])
  end

  helper_method :dog

  def fetch!
    dog.url = dog.random! if dog.valid?
  end
end
