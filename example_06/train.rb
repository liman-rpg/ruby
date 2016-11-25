require_relative 'manufacturer'

class Train
  include Manufacturer
  attr_reader :number, :route, :current_index

  class << self
    @@all_train = {}

    def find(train_name)
      @@all_train[train_name]
    end
  end

  def initialize(number, size)
    @number = number
    # @type = type # passenger or cargo
    @size = size
    valid?
    @speed = 0
    @vagon_list = Array.new(size) { |i| nil }
    @route = []
    @current_index = nil
    @on_station = false
    @list = nil
    @@all_train[@number] = self
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

  def add_vagon(vagon)
    raise ArgumentError, "Vagon is existed !" if @vagon_list.include?(vagon)

    i = @vagon_list.index(nil)

    unless i.nil?
      @vagon_list[i] = vagon
      vagon.link_to_id(i + 1)
    else
      puts "Состав полон"
    end
  end

  def del_vagon(vagon)
    i = @vagon_list.index(vagon)

    if i
      @vagon_list[i] = nil
      vagon.del_id
    else
      puts "В составе нет такого вагона"
    end
  end

  def total_vagon
    @vagon_count
  end

  def add_route(route)
    @route.push(route)
    current_station
  end

  def current_station
    check

    return if @on_station == false

    init_current_index
  end

  def next_station
    return if @route.empty? || @current_index.nil? || @route[0].last_station.train_list.include?(self)

    delete_self_in_current_station
    @list[@current_index + 1].add_train(self)
    @current_index += 1
  end

  def prev_station
    return if @route.empty? || @current_index.nil? || @current_index == 0

    delete_self_in_current_station
    @list[@current_index - 1].add_train(self)
    @current_index -= 1
  end

  def show_station
    init_list
    puts "Предыдущая станция #{@list[@current_index - 1].name}" unless @current_index == 0
    puts "Текущая станция #{@list[@current_index].name}"

    if @current_index < (@list.count - 1)
      puts "Следующая станция #{@list[@current_index + 1].name}"
    end
  end

  private

  def check
    test = []
    init_list
    test.push(@list.select { |station| station.train_list.include?(self) })
    test.flatten!

    if test.empty?
      puts "Поезд не принадлежит не одной станции"
    elsif test.count == 1
      puts "Поезд находится на станции #{test[0].name}"
      @on_station = true
    elsif test.count > 1
      puts "ВНИМАНИЕ! Поезд находится сразу на нескольких станциях!"
    end
  end

  def delete_self_in_current_station
    init_list
    @list[@current_index].del_train(self)
  end

  def init_list
    @list = @route[0].route_list.flatten
  end

  def init_current_index
    init_list
    @list.map.with_index do |st, i|
      @current_index = i if st.train_list.include?(self)
    end
  end

  def valid?
    raise ArgumentError, "Number can't be blank" if @number.nil?
    raise ArgumentError, "Input Number error. The Number is not String" unless @number.is_a?(String)
    raise ArgumentError, "Number can't be blank" if @number.empty?
    # raise ArgumentError, "Type can't be blank" if @type.nil?
    # raise ArgumentError, "Input Type error. The Type is not Symbol" unless @type.is_a?(Symbol)
    # raise ArgumentError, "Input Type error. Use :p or :c" unless @type == :p || @type == :c
    raise ArgumentError, "Size can't be blank" if @size.nil?
    raise ArgumentError, "Input Size error. The Size is not Integer" unless @size.is_a?(Integer)
    raise ArgumentError, "Input Size error. The Size must be greater than 0" if @size <= 0
    true
  end
end
