require 'commands/command'

class Init < Command
  COMMAND = 'init'
  ARGS = 'W H'
  HELP = 'Initialises an empty W x H warehouse.'

  def execute(args)
    if warehouse.width
      puts "> IMPORTANT. This will fully reset your current warehouse (#{warehouse.width} x #{warehouse.height}) and remove any crate(s). Please confirm [y/n] if you would like to continue."
      confirmation_message(args)
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

  def confirmation_message(args)
    user_input = gets.chomp
    if user_input == 'y'
      create_warehouse(args)
    elsif user_input == 'n'
      "> No warehouse created - current warehouse retained (#{warehouse.width} x #{warehouse.height}). #{CommandLineInterface::HINT}"
    else
      puts "> Input not recognised. Please enter `y` to reset and create a new warehouse or `n` to keep your current warehouse."
      confirmation_message(args)
    end
  end
end
