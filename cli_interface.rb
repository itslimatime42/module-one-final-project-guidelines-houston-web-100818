require_relative 'config/environment'

$menu_choices = {
  "Search Houston bars by name" => 0,
  "Search Houston's nastiest bars" => 1,
  "Ask an expert" => 2
}

$nasty_menu_choices = {
  "Use our nasty words" => 0,
  "Use your own nasty word" => 1
}

$expert_menu_choices = {
  "Find which bars are hated by Houston's angriest patron" => 0,
  "Worst date spot in town" => 1,
  "Where to take your sidepiece - ask an expert" => 2
}

$prompt = TTY::Prompt.new

def welcome_get_name
  name = $prompt.ask("Welcome to the Houston Shady Bar Search. What's your name?") do |q|
    q.required true
    q.validate /\A\w+\Z/
    q.modify   :capitalize
  end
end

def move_on(name)
  move_on = $prompt.select("\n#{name}, are you ready to explore the seedy underbelly of Houston?", %w(Yes No))
end

def exit
  puts "Go back to your sheltered, uninteresting life!"
end

def continue_message
  move_on_again = $prompt.select("\nAre you sure you can handle it?", %w(I\ was\ born\ ready Probably\ not))
  if move_on_again == "Probably not"
    print "\nYou're probably right. Let's do this anyway. "
    return "scaredy cat"
  else
    print "\nOh, you bad! "
    return "bad boy"
  end
end

def continue(name)
  choice = start_menu(name)

  case choice
  when 0

  when 1

  when 2

  end
end

def start_menu(name)
  categories = $prompt.select("Alright #{name}, pick your poison:", $menu_choices)
end

def side_piece
  result = User.side_pieces


  # { name: name, recommendation: bar, review: review.content }
end

def validate_input(input)

end

def run_program
  name = welcome_get_name
  yes_or_no = move_on(name)

  if yes_or_no == "No"
    exit
  else
    name = continue_message
    continue(name)
  end

end

run_program
