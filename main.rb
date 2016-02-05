require 'pry'
require './colors'

class Game
  TLINE = "-" * 29 + "\n"
  BLINE = "\n" + "-" * 29 + "\n\n"
  TSTAR = "*".cyan * 29 + "\n"
  BSTAR = "\n" + "*".cyan * 29
  LINE3 = "\n\n\n"

  def initialize
    # Player One
    @p1_name = ""
    @p1_health = 5
    @p1_score = 0

    # Player Two
    @p2_name = ""
    @p2_health = 5
    @p2_score = 0

    @winner = ""
    @turn = 1

    @answer = 0
    @correct = 0
  end

  # ------------------------------------------
  # The game begins here
  # ------------------------------------------

  def intro
    puts TLINE + "*".cyan * 8 + " MATH MANIA! ".red.blink.bold + "*".cyan * 8 + BLINE
    print "Player 1 Name:".underline.bold + " "
    @p1_name = gets.chomp.capitalize
    puts "\n\n"
    print "Player 2 Name:".underline.bold + " "
    @p2_name = gets.chomp.capitalize
    puts "\n"
    puts TLINE + TSTAR + "*".cyan * 11 + " START ".red.bold + "*".cyan * 11 + BSTAR + BLINE
    return generate_question
  end

  # ------------------------------------------
  # Generate 2 random numbers and determines
  # which operator will be used in the question
  # ------------------------------------------

  def generate_question

    # Generates random numbers
    @num1 = rand(1..20)
    @num2 = rand(1..20)

    # Determines which players is asked a questoin
    if @turn == 1
      puts "#{@p1_name}'s Turn!".underline.bold + "\n\n"
    elsif @turn == 2
      puts "#{@p2_name}'s Turn!".underline.bold + "\n\n"
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

  # ------------------------------------------
  # The Questions
  # ------------------------------------------

  def addition
    print "What is #{@num1} + #{@num2}? "
    @answer = gets.chomp.to_i
    puts TLINE
    @correct =  (@num1 + @num2)
    return verifiy_answer
  end

  def subtraction
    print "What is #{@num1} - #{@num2}? "
    @answer = gets.chomp.to_i
    puts TLINE
    @correct =  (@num1 - @num2)
    return verifiy_answer
  end

  def multiplication
    print "What is #{@num1} * #{@num2}? "
    @answer = gets.chomp.to_i
    puts TLINE
    @correct =  (@num1 * @num2)
    return verifiy_answer
  end

  def division
    print "What is #{@num1} ÷ #{@num2}? "
    @answer = gets.chomp.to_i
    puts TLINE
    @correct =  (@num1 / @num2)
    return verifiy_answer
  end

  # ------------------------------------------
  # Does what it says... It verifies.
  # ------------------------------------------

  def verifiy_answer
    @answer == @correct ? correct_answer : wrong_answer
  end

  # ------------------------------------------
  # When a player answers a question one of
  # these methods will run
  # ------------------------------------------

  def correct_answer
    case @turn
    when 1
      @p1_score += 100
      @turn = 2
      puts TSTAR + "CORRECT!".bold + BSTAR
      puts TLINE + "#{@p1_name}  +100 points" 
      puts "\n\n"
      return generate_question
    when 2
      @p2_score += 100
      @turn = 1
      puts TSTAR + "CORRECT!".bold + BSTAR
      puts TLINE + "#{@p1_name} +100 points" 
      puts "\n\n"
      return generate_question
    end
  end

  def hearts(int)
    "♥" * int
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
        puts TSTAR + "WRONG!".red.bold + BSTAR
        puts "The answer was #{@correct}"
        puts TLINE + "#{@p1_name} lost a life: #{hearts(@p1_health)} left." + BLINE
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
        puts TSTAR + "WRONG!".red.bold + BSTAR
        puts "The answer was #{@correct}"
        puts TLINE + "#{@p2_name} lost a life: #{hearts(@p2_health)} left." + BLINE
        puts "\n\n"
        return generate_question
      end
    end
  end

  # ------------------------------------------
  # Once a player's health reaches 0 this 
  # method will run
  # ------------------------------------------

  def game_over
    puts "\n\n\n\n\n\n"
    puts "-" * 29
    puts "*".cyan * 29
    puts "*".cyan * 9 + " GAME OVER ".red.bold + "*".cyan * 9
    puts "*".cyan * 29
    puts "-" * 29
    puts LINE3 + " " * 8 + "#{@winner} WINS!!!".underline.bold.blink + LINE3
    puts TLINE + "FINAL SCORE".bold.red
    puts "-" * 29
    puts "#{@p1_name}".ljust(10) + "#{@p1_score} pts".rjust(19)
    puts "#{@p2_name}".ljust(10) + "#{@p2_score} pts".rjust(19) + BLINE
    print LINE3 + " " * 2 + "[Press Enter to Restart]".blink
    puts "\n\n\n\n\n\n"
      enter = gets 
      if enter == "\n"
        return intro
      else
        return
      end
  end

end

# ------------------------------------------
# Call
# ------------------------------------------

Game.new.intro

