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
    @train_list.push(train)
  end

  def list_train
    @train_list
  end

  def del_train(train)
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
