require 'commands/command'

class Init < Command
  COMMAND = 'init'
  ARGS = 'W H'
  HELP = 'Initialises the application as an empty W x H warehouse.'

  def execute(args)
    if warehouse.width
      puts "> IMPORTANT. This will fully reset your current warehouse (#{warehouse.width} x #{warehouse.height}) and remove any crate(s). Please confirm [y/n] if you would like to continue."
      gets.chomp == 'y' ? create_warehouse(args) : "> No warehouse created - current warehouse retained (#{warehouse.width} x #{warehouse.height}). #{CommandLineInterface::HINT}"
    else
      create_warehouse(args)
    end
  end

  private

  def create_warehouse(args)
    width, height = args.map(&:to_i)
    warehouse.init(width, height)
    "> Warehouse created (#{width} x #{height})."
  end
end
