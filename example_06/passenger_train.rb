require_relative 'train'

class PassengerTrain < Train
  def add_vagon(vagon)
    super if vagon.is_a?(PassengerVagon)
  end

  def del_vagon(vagon)
    super if vagon.is_a?(PassengerVagon)
  end
end
