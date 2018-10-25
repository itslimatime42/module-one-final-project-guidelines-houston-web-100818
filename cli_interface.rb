require_relative 'config/environment'

$bar_types = {
  "sports" => 0,
  "drag" => 1,
  "brewery" => 2,
  "cocktail" => 3,
  "irish pub" => 4,
  "gastropub" => 5,
  "lounge" => 6,
  "club" => 7,
  "dive" => 8,
  "wine" => 9,
}


$prompt = TTY::Prompt.new

def welcome_get_name
  name = $prompt.ask("Welcome to the Houston Shady Bar Search. What's your name?", default: "Anonymous") do |q|
    q.required true
    q.validate /\A\w+\Z/
    q.modify   :capitalize
  end
end

def move_on(name)
  move_on = $prompt.yes?("#{name}, are you ready to explore the seedy underbelly of Houston?") do |q|
    q.required true
  end
end

def exit
  puts "Go back to your sheltered, uninteresting life!"
end

def continue
  move_on_again = $prompt.yes?("Are you sure you can handle it?")
  if move_on_again == false
    puts "You're probably right. Let's do this anyway."
  else
    puts "Oh, you bad!"
  end
end

def start_menu
  categories = $prompt.multi_select("Select the bar types you'd like to explore. Hit space bar to make a selection, and hit enter when you are finished adding selections.", $bar_types)
end

# def execute
#
# def run_program
#   name = welcome_get_name
#   yes_or_no = move_on(name)
#
#   if yes_or_no == false
#     exit
#   else
#     continue
#   end
#
#   choices = start_menu
#   case choices
#   when <condition>
#   when <condition>
#   when <condition>
#   end
# end
