require_relative "factory_train"
require_relative "station"
require_relative "route"

class Main
  attr_accessor :commands, :counts, :train
  def initialize
    @commands =
      {
        '1' => ['Help', []],
        '2' => ['Create Train', ['Number', 'Type', 'Size']],
        '3' => ['Create Station', ['Name']],
        '4' => ['Create Route', ['Name', 'First station', 'Last station']],
        '5' => ['Show', []],
        '0' => ['Exit', []]
      }
    @train = {}
    @station = {}
    @route = {}
    # @counts = []
    @inputs = []
    # init_counts
    @print_command = lambda do |k, v|
      # puts "#{k}"
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
            show
          end
          break if command_name == '0'
        else
          puts "You need help"
        end
      rescue Exception => e
        puts e.message
      end
    end
  end

  # def init_counts
  #   @commands.each_value { |v| @counts << v[1].size }
  # end

  protected
  def valid?
    return false if @input_params == nil
    return false unless @input_params.any?
    return false unless @commands.has_key?(@input_params[0])
    # command_param = @commands[@input_params[0]][1]
    # return true if command_param.empty?
    # return true if(command_param.size == (@input_params.size - 1) )
    # puts "You entered wrong params for command:"
    # @print_command.call(@input_params[0], command_param)
    # return false
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

  def show
    puts "Список Trains :"
    @train.each do |train_number, obj|
      if obj.is_a?(PassengerTrain)
        puts "Пассажирские :"
        puts "#{train_number}"
      elsif obj.is_a?(CargoTrain)
        puts "Грузовые :"
        puts "#{train_number}"
      end
    end

    puts "Список Stations :"
    @station.each_key {|k| puts "#{k}"}

    puts "Список Routes :"
    @route.each_key {|k| puts "#{k}"}
  end

  def help
    puts '_____________________'
    @commands.each { |k,v| puts "#{k} --> #{v[0]}" }
    puts '_____________________'
  end

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
