require 'commands/command'
require 'pry'

class Locate < Command
  COMMAND = 'locate'
  ARGS = 'P'
  HELP = 'Show a list of all locations occupied by a crate with product code P displayed as (X,Y).'

  def execute(args)
    if warehouse.width.nil?
      "> No crates found as you have not yet created a warehouse. #{CommandLineInterface::HINT}"
    elsif
      warehouse.grid.flatten.all?(" .")
      "> No crates found in the warehouse."
    else
      warehouse.locate_crate_coordinates(args.first)
    end
  end
end
