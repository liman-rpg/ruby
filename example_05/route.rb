class Route
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @intermediate_station = []
    @route_list = [@first_station, @intermediate_station, @last_station]
  end

  def add_station(station)
    @intermediate_station.push(station)
  end

  def del_station(station)
    @intermediate_station.delete(station)
  end

  def list_station
    @route_list
  end
end
