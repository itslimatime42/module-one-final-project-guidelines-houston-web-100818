require_relative 'config/environment'

$prompt = TTY::Prompt.new

$start_menu_choices = {
  "Search seedy Houston bars by name" => 0,
  "Search Houston's nastiest bars" => 1,
  "Ask an expert" => 2,
  "Exit" => 3
}

$nasty_menu_choices = {
  "Use our nasty words" => 0,
  "Use your own nasty word" => 1,
  "Back" => 2
}

$expert_menu_choices = {
  "Worst date spot in town" => 0,
  "Personal favorites of H-town's most unsatisfied patron" => 1,
  "Where to take your sidepiece or find where your bae may be taking theirs" => 2,
  "Back" => 3
}

def messages(name=nil)
  {
    start: "Pick your poison:",
    nasty: "\nHow nasty you feelin'?",
    expert: "\nWhat kind of recommendation you lookin' for?",
    nasty_word: "\nGimme your nasty word: ",
    move_on: "\n#{name}, are you ready to explore the seedy underbelly of Houston?",
    move_on_again: "\nAre you sure you can handle it?",
    continue_message1: "\nYou're probably right. Let's do this anyway.",
    continue_message2: "\nOh, you bad! ",
    welcome: "\nWelcome to the Houston Shady Bar Search. What's your name?",
    input_error: "That word was a little too nasty, try again.",
    exit: "\nGo back to your sheltered, uninteresting life!\n",
    bar_search: "\nEnter the seedy bar you're looking for to get its reviews: "
  }
end

def response_choices
  {
    move_on_choices: %w(Yes No),
    move_on_again_choices: %w(I\ was\ born\ ready Probably\ not)
  }
end

def welcome_get_name
  name = $prompt.ask(messages[:welcome]) do |q|
    q.required true
    q.validate /\A\w+\Z/
    q.modify   :capitalize
  end
end

def move_on(name)
  move_on = $prompt.select(messages(name)[:move_on], response_choices[:move_on_choices])
end

def exit?
  puts messages[:exit]
  exit
end

def continue_message
  move_on_again = $prompt.select(messages[:move_on_again], response_choices[:move_on_again_choices])
  if move_on_again == "Probably not"
    print messages[:continue_message1]
    return "scaredy cat"
  else
    print messages[:continue_message2]
    return "ya bad thing"
  end
end

def launch_menu(menu_choice, message)
  $prompt.select(message, menu_choice)
end

def launch_first_menu(name=nil)
  start_choice = launch_menu($start_menu_choices, messages(name)[:start])

  case start_choice
  when 0
    bar_name = $prompt.select(messages[:bar_search], filter: true) do |options|
      Bar.all.collect do |bar|
        options.choice bar.name
      end
    end
    bar_reviews = Bar.find_by(name: bar_name).reviews.order("rating")
    bar_search_printer(bar_name, bar_reviews)
    launch_first_menu
  when 1
    nasty_choice = launch_menu($nasty_menu_choices, messages[:nasty])
    launch_nasty_menu(nasty_choice)
  when 2
    expert_choice = launch_menu($expert_menu_choices, messages[:expert])
    launch_expert_menu(expert_choice)
  when 3
    exit
  end
end

def launch_nasty_menu(nasty_choice)
  case nasty_choice
  when 0
    our_nasty_hash = Bar.nasty?
    nasty_printer(our_nasty_hash)
    launch_first_menu
  when 1
    your_nasty_word = $prompt.ask(messages[:nasty_word]) do |q|
      q.required true
    end
    your_nasty_hash = Bar.nasty?(your_nasty_word)
    if your_nasty_hash.empty? == true
      puts messages[:input_error]
      launch_nasty_menu(nasty_choice)
    end
    nasty_printer(your_nasty_hash)
    launch_first_menu
  when 2
    launch_first_menu
  end
end

def launch_expert_menu(expert_choice)
  case expert_choice
  when 0
    worst_date_and_sidepiece_printer(Review.worst_date_ever)
    launch_first_menu
  when 1
    angriest_user_printer(User.angriest_user_reviews)
    launch_first_menu
  when 2
    worst_date_and_sidepiece_printer(User.side_pieces)
    launch_first_menu
  when 3
    launch_first_menu
  end
end

def nasty_printer(nasty_hash)
  nasty_hash.each do | bar, review_array |
    review_array.each do | review |
      puts "\nBar: #{bar}"
      puts "\nRating: #{review["rating"]}"
      puts "\nReview:\n#{review["content"]}"
      puts "\n* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
    end
  end
end

def worst_date_and_sidepiece_printer(review_array)
  review_array.each do | review |
    puts "\nName: #{review[:name]}"
    puts "\nBar: #{review[:bar]}"
    puts "\nReview:\n#{review[:review]}"
    puts "\n* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
  end
end

def angriest_user_printer(user_hash)
  puts "\nName: #{user_hash[:name]}"
  puts "\nNumber of unsatisfied reviews: #{user_hash[:count]}"
  puts "\n* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
  user_hash[:reviews].each do | review |
    puts "\nBar: #{review.keys[0]}"
    puts "\nReview:\n#{review.values[0]}"
    puts "\n* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
  end
end

def bar_search_printer(name, review_array)
  puts "\nBar: #{name}"
  puts "\n* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
  review_array.each do |review|
    puts "\nRating: #{review[:rating]}"
    puts "\nReview:\n#{review[:content]}"
    puts "\n* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
  end
end

def run_program
  name = welcome_get_name
  yes_or_no = move_on(name)

  if yes_or_no == "No"
    exit?
  else
    name = continue_message
    launch_first_menu(name)
  end
end

run_program
