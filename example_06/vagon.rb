require_relative 'manufacturer'

class Vagon
  include Manufacturer

  def link_to_id(id)
    @number = id
  end

  def del_id
    @number = nil
  end
end
