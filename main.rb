require 'pry'
# require 'colorize'
require './colors'

class Game

LINE = "-" * 29

def initialize
  @p1_name = ""
  @p1_health = 5
  @p1_score = 0

  @p2_name = ""
  @p2_health = 5
  @p2_score = 0

  @winner = ""
  @turn = 1
end

# *****************************************
# *****************************************

def intro
  puts "-" * 28
  puts "*".cyan * 8 + " MATH MANIA ".red.blink.bold + "*".cyan * 8
  puts "-" * 28 + "\n\n"
  print "Player 1 Name:".underline + " "
  @p1_name = gets.chomp
  puts "\n\n"
  print "Player 2 Name:".underline + " "
  @p2_name = gets.chomp 
  # puts "\n\n"
  # puts " " * 8 + "Difficulty".underline
  # puts "\n\n"
  # puts "[1]Easy [2]Medium [3]Nerd"
  # skill_level = gets.chomp
  # @difficulty = skill_level
  puts "\n\n"
  puts "-" * 29
  puts "*".cyan * 29
  puts "*".cyan * 8 + " LET'S BEGIN ".red.bold + "*".cyan * 8
  puts "*".cyan * 29
  puts "-" * 29
  puts "\n\n"
  return generate_question
end

# *****************************************
# *****************************************

def generate_question
  # Generates random numbers
  @num1 = rand(1..20)
  @num2 = rand(1..20)
  if @turn == 1
    puts "#{@p1_name}'s Turn!".bold.underline.cyan
    puts "\n\n"
  elsif @turn == 2
    puts "#{@p2_name}'s Turn!".bold.underline.cyan
    puts "\n\n"
  end
  # Determines which operator to use
  operator = rand(1..3)
  case operator
  when 1
    return addition
  when 2
    return subtraction
  when 3
    return multiplication
  when 4
    return division
  end
end

# *****************************************
# *****************************************

def addition
  print "What is #{@num1} + #{@num2}? "
  answer = gets.chomp.to_i
  correct =  @num1 + @num2
  if answer == correct

    puts "CORRECT!".bold
    return correct_answer
  else
    puts "WRONG!".red.bold
    return wrong_answer
  end
end

def subtraction
  print "What is #{@num1} - #{@num2}? "
  answer = gets.chomp.to_i
  correct =  @num1 - @num2
  if answer == correct
    puts "CORRECT!".bold
    return correct_answer
  else
    puts "WRONG!".red.bold
    return wrong_answer
  end
end

def multiplication
  print "What is #{@num1} * #{@num2}? "
  answer = gets.chomp.to_i
  correct =  @num1 * @num2
  if answer == correct
    puts "CORRECT!".bold
    return correct_answer
  else
    puts "WRONG!".red.bold
    return wrong_answer
  end
end

def division
  print "What is #{@num1} ÷ #{@num2}? "
  answer = gets.chomp.to_i
  correct =  @num1 / @num2
  if answer == correct
    puts "CORRECT!".bold
    return correct_answer
  else
    puts "WRONG!".red.bold
    return wrong_answer
  end
end

# *****************************************
# *****************************************

def correct_answer
  case @turn
  when 1
    @p1_score += 100
    @turn = 2
    puts "\n\n"
    puts LINE
    puts "#{@p1_name}  +100 points"
    puts LINE
    puts "\n\n"
    return generate_question
  when 2
    @p2_score += 100
    @turn = 1
    puts "\n\n"
    puts LINE
    puts "#{@p1_name} +100 points"
    puts LINE
    puts "\n\n"
    return generate_question
  end
end

def wrong_answer
  case @turn
  when 1
    @p1_health -= 1
    if @p1_health == 0
      @winner = @p2_name
      return game_over
    else
      @turn = 2
      puts "\n\n"
      puts LINE
      puts "#{@p1_name} lost a life: #{@p1_health}"
      puts LINE
      puts "\n\n"
      return generate_question
    end
  when 2
    @p2_health -= 1
    if @p2_health == 0
      @winner = @p1_name
      return game_over
    else
      @turn = 1
      puts "\n\n"
      puts LINE
      puts "#{@p2_name} lost a life: #{@p2_health}"
      puts LINE
      puts "\n\n"
      return generate_question
    end
  end
end

# *****************************************
# *****************************************

def game_over
  puts "\n\n\n\n\n\n"
  puts "-" * 29
  puts "*".cyan * 29
  puts "*".cyan * 9 + " GAME OVER ".red.bold + "*".cyan * 9
  puts "*".cyan * 29
  puts "-" * 29
  puts "\n\n"
  puts " " * 6 + "#{@winner} WINS!!!".underline.bold.blink
  puts "\n\n"
  puts "FINAL SCORE".bold.red
  puts "-" * 29
  puts "#{@p1_name}".ljust(10) + "#{@p1_score} pts".rjust(19)
  puts "#{@p2_name}".ljust(10) + "#{@p2_score} pts".rjust(19)
  puts "-" * 29
  puts "\n\n\n"
  print " " * 2 + "[Press Enter to Restart]"
  puts "\n\n\n\n\n\n"
    enter = gets 
    if enter == "\n"
      return intro
    else
      return
    end
end

end

Game.new.intro

