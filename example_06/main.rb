require_relative "factory_train"
require_relative "station"
require_relative "route"
require_relative "passenger_vagon"
require_relative "cargo_vagon"

class Main
  attr_accessor :commands, :counts, :train, :vagon, :station
  def initialize
    @commands =
      {
        '1' => ['Help', []],
        '2' => ['Create Train', ['Number', 'Type', 'Size']],
        '3' => ['Create Station', ['Name']],
        '4' => ['Create Route', ['Name', 'First station', 'Last station']],
        '5' => ['Create Vagon', ['Name', 'Type', 'Size']],
        '6' => ['Add Train in Station', ['Select Station', 'Select Train']],
        '9' => ['Show', []],
        '0' => ['Exit', []]
      }
    @train = {}
    @station = {}
    @route = {}
    @vagon = {}
    @inputs = []
    @print_command = lambda do |k, v|
      if v.any?
        i = 1
        v.each do | item |
          puts "#{@commands[k][0]} need param #{i} --> #{item}"
          i += 1
        end
      end
    end
  end

  def cli
    loop do
      begin
        help
        params = gets.chomp
        @input_params = params.split(" ")

        if valid?
          command_name = @input_params[0]
          if command_name == '1'
            help
          elsif command_name == '2'
            create_train(command_name)
          elsif command_name == '3'
            create_station(command_name)
          elsif command_name == '4'
            create_route(command_name)
          elsif command_name == '5'
            create_vagon(command_name)
          elsif command_name == '6'
            add_train_in_station
          elsif command_name == '9'
            show
          end
          break if command_name == '0'
        else
          puts "You need help"
        end
      rescue Exception => e
        puts e.message
        @inputs = []
      end
    end
  end

  protected

  def valid?
    return false if @input_params == nil
    return false unless @input_params.any?
    return false unless @commands.has_key?(@input_params[0])
    true
  end

  def create_train(e)
    require_params(e)
    train_number = @inputs[0]
    train_type = @inputs[1]
    train_size = @inputs[2]

    raise ArgumentError, "Train with number #{train_number} is existed!" if @train.has_key?(train_number)

    @train[train_number] = FactoryTrain.create(train_number, train_type.to_sym, train_size.to_i)
    puts "Add train #{train_number}"
    @inputs = []
  end

  def create_station(e)
    require_params(e)
    station_name = @inputs[0]

    raise ArgumentError, "Station with name #{station_name} is existed!" if @station.has_key?(station_name)

    @station[station_name] = Station.new(station_name)
    puts "Add Station #{station_name}"
    @inputs = []
  end

  def create_route(e)
    puts "Список Stations :"
    @station.each_key {|k| puts "#{k}"}

    require_params(e)
    route_name = @inputs[0]
    first_station = @inputs[1]
    last_station = @inputs[2]

    raise ArgumentError, "Route with name #{route_name} is existed!" if @route.has_key?(route_name)

    @route[route_name] = Route.new(@station[first_station], @station[last_station])
    puts "Add Route #{route_name}"
    @inputs = []
  end

  def create_vagon(e)
    require_params(e)
    vagon_name = @inputs[0]
    vagon_type = @inputs[1]
    vagon_size = @inputs[2]

    raise ArgumentError, "Vagon with name #{vagon_name} is existed!" if @vagon.has_key?(vagon_name)

    if vagon_type == 'p'
      @vagon[vagon_name] = PassengerVagon.new(vagon_size.to_i)
    elsif vagon_type == 'c'
      @vagon[vagon_name] = CargoVagon.new(vagon_size.to_i)
    else
      raise ArgumentError, "Vagon type error !!!"
    end

    puts "Add Vagon #{vagon_name}"
    @inputs = []
  end

  def add_train_in_station
    raise ArgumentError, "Station HASH empty" if @station.empty?
    raise ArgumentError, "Train HASH empty" if @train.empty?

    i_st = 1
    i_tr = 1
    stations = {}
    trains = {}

    puts "Select Station :"
    @station.each_pair do |k, v|
      puts "#{i_st} -- > #{k}"
      stations[i_st] = v
      i_st += 1
    end
    selected_station = gets.chomp.to_i

    puts "Select Train :"
    @train.each_pair do |k, v|
      puts "#{i_tr} -- > #{k}"
      trains[i_tr] = v
      i_tr += 1
    end
    selected_train = gets.chomp.to_i

    raise ArgumentError, "Input Select Station not valid" if selected_station.nil? || selected_station <= 0 || selected_station > i_st
    raise ArgumentError, "Input Select Station not valid" if selected_train.nil? || selected_train <= 0 || selected_train > i_tr

    stations[selected_station].add_train(trains[selected_train])

    puts "Add Train #{trains[selected_train].number} in Station #{stations[selected_station].name}"
    @inputs = []
  end

  def show
    puts "Список Trains :"
    @train.each do |train_number, obj|
      if obj.is_a?(PassengerTrain)
        puts "  Пассажирские :"
        puts "    #{train_number}"
      elsif obj.is_a?(CargoTrain)
        puts "  Грузовые :"
        puts "    #{train_number}"
      end
    end

    puts "Список Stations :"
    @station.each do |k, v|
      puts "  #{k}"
      unless v.train_list.empty?
        puts "    содержит поезда:"
        v.train_list.each_with_index {|obj, i| puts "      #{i + 1} -- > #{obj.number}"}
      end
    end

    puts "Список Routes :"
    @route.each_key {|k| puts "  #{k}"}

    puts "Список Vagons :"
    @vagon.each do |vagon_name, obj|
      if obj.is_a?(PassengerVagon)
        puts "  Пассажирские :"
        puts "    #{vagon_name}"
      elsif obj.is_a?(CargoVagon)
        puts "  Грузовые :"
        puts "    #{vagon_name}"
      end
    end
  end

  def help
    puts '_____________________'
    @commands.each { |k,v| puts "#{k} --> #{v[0]}" }
    puts '_____________________'
  end

  # def select(hash_obj)
  #   items = {}
  #   i = 1

  #   hash_obj.each do |k, v|
  #     puts "#{i} -- > #{k}"
  #     items[i] = v
  #     i += 1
  #   end
  # end

  def require_params(iter)
    @print_command.call(@input_params[0], @commands[@input_params[0]][1])
      i = 0
    loop do
      begin
        @inputs.push(gets.chomp)
        i += 1
      break if i == @commands[iter][1].length

      rescue Exception => e
        puts e.message
      end
    end
  end
end
