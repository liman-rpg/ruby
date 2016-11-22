require_relative "passenger_train"
require_relative "cargo_train"

class FactoryTrain
  def self.create(number, type, size)
    train = nil
    if type == :p
      train = PassengerTrain.new(number, size)
    elsif type == :c
      train = CargoTrain.new(number, size)
    else
      raise ArgumentError, "This type #{type} of train is not existed!"
    end
    return train
  end
end
