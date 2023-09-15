require 'commands/command'

class View < Command
  COMMAND = 'view'
  ARGS = ''
  HELP = 'Outputs a visual representation of the current state of the grid.'

  def execute(_args)
    if warehouse.width.nil?
      "> You have not yet created a warehouse. Please type `init W H`, with W being a number that represents the width and H being a number that represents the height."
    else
      warehouse.grid.reverse.map(&:join).join("\n")
    end
  end
end
