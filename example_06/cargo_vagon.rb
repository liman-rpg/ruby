require_relative 'vagon'

class CargoVagon < Vagon
  attr_accessor :number

  def initialize(size)
    @max_loading = size
    @free_place = size
  end

  def loading_cargo(load)
    @free_place -= load if load <= @free_place
  end

  def free_place(load)
    @free_place += load if load <= @max_loading - @free_place
  end

  def size_loading_cargo
    @max_loading - @free_place
  end

  def size_free_cargo
    @free_place
  end
end
