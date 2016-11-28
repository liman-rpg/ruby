require_relative "passenger_train"
require_relative "cargo_train"

class Station
  attr_reader :name, :train_list

  class << self
    @@count = 0

    def all
      @@count
    end
  end

  def initialize(name)
    @name = name
    valid?
    @train_list = []
    @@count += 1
  end

  def add_train(train)
    raise ArgumentError, "Input Train error. The Train is not Train::Class " unless train.is_a?(PassengerTrain) || train.is_a?(CargoTrain)
    raise ArgumentError, "Train with number #{train.number} is existed!" if @train_list.include?(train)

    @train_list.push(train)
  end

  def list_train
    @train_list
  end

  def del_train(train)
    raise ArgumentError, "Input Train error. The Train is not Train::Class " unless train.is_a?(PassengerTrain) || train.is_a?(CargoTrain)
    raise ArgumentError, "Train with number #{train.number} is not existed!" unless @train_list.include?(train)

    @train_list.delete(train)
  end

  def sorting_for_type
    pass = @train_list.select { |train| train.type == :p }
    puts "Кол-во пассажирских поездов #{pass.count}"
    pass.each { |train| puts train.number }

    cargo = @train_list.select { |train| train.type == :c }
    puts "Кол-во грузовых поездов #{cargo.count}"
    cargo.each { |train| puts train.number }
  end

  private

  def valid?
    raise ArgumentError, "Name can't be blank" if @name.nil?
    raise ArgumentError, "Input Name error. The Name is not String" unless @name.is_a?(String)
    raise ArgumentError, "Name can't be blank" if @name.empty?
    true
  end
end
