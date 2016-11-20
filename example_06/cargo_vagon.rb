require_relative 'vagon'

class CargoVagon < Vagon
  attr_accessor :number

  def initialize(size)
    @max_loading = size
    @free_place = size
    valid?
  end

  def loading_cargo(load)
    raise ArgumentError, "Input 'load' must be greater than 0" if load < 0
    raise ArgumentError, "Input is large" unless load <= @free_place

    @free_place -= load
  end

  def free_place(load)
    raise ArgumentError, "Input 'load' must be greater than 0" if load < 0
    raise ArgumentError, "Input is large" unless load <= @max_loading - @free_place

    @free_place += load
  end

  def size_loading_cargo
    @max_loading - @free_place
  end

  def size_free_cargo
    @free_place
  end

  private

  def valid?
    raise ArgumentError, "Size can't be blank" if @max_loading.nil? || @free_place.nil?
    raise ArgumentError, "Input Size error. The Size is not Integer" unless @max_loading.is_a?(Integer) || @free_place.is_a?(Integer)
    raise ArgumentError, "Input Size error. The Size must be greater than 0" if @max_loading <= 0 || @free_place <= 0
    true
  end
end
