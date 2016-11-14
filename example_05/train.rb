class Train
  attr_reader :type, :number

  def initialize(number, type, size)
    @number = number
    @type = type # :passenger and :cargo
    @size = size
    @speed = 0
    @vagon_count = 0
  end

  def accelerate_speed
    @speed += 10 if @speed < 110
  end

  def current_speed
    @speed
  end

  def brake_speed
    @speed -= 10 if @speed > 0
  end

  def add_vagon
    @vagon_count += 1 if @speed == 0
  end

  def del_vagon
    @vagon_count -= 1 if @speed == 0 && @vagon_count > 0
  end

  def total_vagon
    @vagon_count
  end
end
