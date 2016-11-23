require_relative "station"

class Route
  attr_reader :route_list, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    valid?
    @intermediate_station = []
    @route_list = [@first_station, @intermediate_station, @last_station]
  end

  def add_station(station)
    raise ArgumentError, "Input Station error. The Station is not Station::Class " unless station.is_a?(Station)
    raise ArgumentError, "Stations alrady exists" if @route_list.index(station) || @intermediate_station.index(station)
    @intermediate_station.push(station)
  end

  def del_station(station)
    raise ArgumentError, "Input Station error. The Station is not Station::Class " unless station.is_a?(Station)
    @intermediate_station.delete(station)
  end

  def list_station
    @route_list
  end

  private

  def valid?
    raise ArgumentError, "Stations can't be blank" if @first_station.nil? || @last_station.nil?
    raise ArgumentError, "Input First Station error. The Station is not Station::Class " unless @first_station.is_a?(Station)
    raise ArgumentError, "Input Last Station error. The Station is not Station::Class " unless @last_station.is_a?(Station)
    raise ArgumentError, "First station equal Last station" if @first_station == @last_station
    true
  end
end
