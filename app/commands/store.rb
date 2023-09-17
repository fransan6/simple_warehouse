require 'commands/command'
require 'crate'

class Store < Command
  COMMAND = 'store'
  ARGS = 'X Y W H P'
  HELP = 'Stores a crate of product code P and of size W x H at position (X,Y). The crate will occupy W x H locations on the warehouse grid.'

  def execute(args)
    position_x, position_y, width, height = args.map(&:to_i)
    product_code = args.last
    crate = Crate.new(position_x, position_y, width, height, product_code)
    if warehouse.store?(crate)
      "> Crate (#{crate.width} x #{crate.height}) successfully stored at (#{crate.position_x},#{crate.position_y})."
    else
      "> Crate cannot be stored."
    end
  end
end
