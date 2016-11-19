require_relative 'vagon'

class PassengerVagon < Vagon
  attr_accessor :number

  def initialize(size)
    @max_places = size
    @free_places = size
  end

  def take_place
    @free_places -= 1 if @free_places > 0
  end

  def free_place
    @free_places += 1 if @free_places < @max_places
  end

  def size_take_place
    @max_places - @free_places
  end

  def size_free_place
    @free_places
  end
end
