require_relative 'train'

class CargoTrain < Train
  def add_vagon(vagon)
    super if vagon.is_a?(CargoVagon)
  end

  def del_vagon(vagon)
    super if vagon.is_a?(CargoVagon)
  end
end
