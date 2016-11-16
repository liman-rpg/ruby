class Train
  attr_reader :type, :number, :route, :current_index

  def initialize(number, type, size)
    @number = number
    @type = type # :passenger and :cargo
    @size = size
    @speed = 0
    @vagon_count = 0
    @route = []
    @current_index = nil
    @there_is = false
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

  def add_route(route)
    @route.push(route)
    check
  end

  def current_station
    check

    return if @there_is == false

    list = @route[0].route_list.flatten
    puts "LIST = #{list}"

    list.map.with_index do |st, i|
      @current_index = i if st.train_list.include?(self)
    end
  end

  def next_station
    return if @route.empty? || @current_index.nil? || @route[0].last_station.train_list.include?(self)

    delete_self_in_current_station
    list[@current_index + 1].add_train(self)
    @current_index += 1
  end

  def prev_station
    return if @route.empty? || @current_index.nil? || @current_index == 0

    delete_self_in_current_station
    list[@current_index - 1].add_train(self)
    @current_index -= 1
  end

  private

  def check
    test = []
    list = @route[0].route_list.flatten
    test.push(list.select { |station| station.train_list.include?(self) })
    test.flatten!

    if test.empty?
      puts "Поезд не принадлежит не одной станции"
    elsif test.count == 1
      puts "Поезд находится на станции #{test[0].name}"
      @there_is = true
    elsif test.count > 1
      puts "ВНИМАНИЕ! Поезд находится сразу на нескольких станциях!"
    end
  end

  def delete_self_in_current_station
    list = @route[0].route_list.flatten
    list[@current_index].del_train(self)
  end
end
