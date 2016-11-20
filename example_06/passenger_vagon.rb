require_relative 'vagon'

class PassengerVagon < Vagon
  attr_accessor :number

  def initialize(size)
    @max_places = size
    @free_places = size
    valid?
  end

  def take_place
    raise ArgumentError, "Do not have Free plases" if @free_places <= 0

    @free_places -= 1
  end

  def free_place
    raise ArgumentError, "Max count Free plases" unless @free_places < @max_places

    @free_places += 1
  end

  def size_take_place
    @max_places - @free_places
  end

  def size_free_place
    @free_places
  end

  private

  def valid?
    raise ArgumentError, "Size can't be blank" if @max_places.nil? || @free_places.nil?
    raise ArgumentError, "Input Size error. The Size is not Integer" unless @max_places.is_a?(Integer) || @free_places.is_a?(Integer)
    raise ArgumentError, "Input Size error. The Size must be greater than 0" if @max_places <= 0 || @free_places <= 0
    true
  end
end
