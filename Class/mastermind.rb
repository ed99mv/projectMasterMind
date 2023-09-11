require_relative 'boardtable'
require_relative 'colorcode'
require_relative 'hint'
require_relative 'computer'
require_relative 'instructions'
require_relative 'selection'

class Mastermind
	attr_accessor :gameboard, :win, :turns, :color_spectrum, :player_mode, :computer

	def initialize
		@gameboard = GameBoard.new()
		@win = false
		@turns = 1
		@color_spectrum = ["red", "green", "yellow", "blue", "magenta", "cyan", "white"]
		@player_mode = true
		@computer = Computer.new()
		@nombre
		@instructions = Instructions.new
		@selection = Selection.new
	end

	def play
		instructions
		prompt_switch_mode
		set_solution if @player_mode == false
		start
	end

	def instructions
		@instructions.instructions
	end

	def prompt_switch_mode
		@selection.prompt_switch_mode
	end

	def set_solution
		puts "¿Cuál solución eliges?"
		puts "\nEscriba cuatro colores separados por espacios."
		print "Tus opciones son: \n> "
        @color_spectrum.each do |color|
            print color.colorize(color.to_sym) + " "
            end
		solution = get_player_guess
		@gameboard.solution = ColorCode.new(solution[0], solution[1], solution[2], solution[3])
	end

	def start
		make_guesses
		turns > 12 ? lose : win
	end

	def make_guesses
		while @win == false && @turns < 13
			prompt_guess
			guess = @player_mode ? get_player_guess : get_computer_guess
			add_guess(guess)
			@win = true if gameboard.guesses[12 - @turns].colors == gameboard.solution.colors
			@turns += 1 if @win == false
		end
	end

	def prompt_guess
		puts @player_mode ? "Es tu turno #{@turns} Adivina?" : "\nComputadora, es tu turno #{@turns} Adivina."
		puts "Escriba cuatro colores separados por espacios."
		print "Tus opciones son: \n> "
        @color_spectrum.each do |color|
             print color.colorize(color.to_sym) + " "
        end
	end

	def get_player_guess
		1.times do
			guess = gets.chomp.downcase.split(" ")

			if guess.length != 4
				print "\n¡Ingresaste una cantidad incorrecta de colores! Vuelve a intentarlo:\n> "
				redo
			end

			if !@color_spectrum.include?(guess[0]) || !@color_spectrum.include?(guess[1]) || !@color_spectrum.include?(guess[2]) || !@color_spectrum.include?(guess[3])
				print "\n¡Solo puedes ingresar los colores especificados! Vuelve a intentarlo:\n> "
				redo
			end

			if @player_mode == false
				if guess.uniq.length !=4
					print "\nDebes tener diferentes colores para la solución. Vuelve a intentarlo:\n> "
					redo
				end
			end

			return guess
		end
	end

	def get_computer_guess
		@computer.guess(@gameboard.hints, @turns)
	end

	def add_guess(guess)
		gameboard.guesses[12 - @turns] = ColorCode.new(guess[0], guess[1], guess[2], guess[3])
		gameboard.refresh(12 - @turns)
	end

	def lose
		puts @player_mode ? "#{@nombre} no has podido vencer el juego. Está bien! Vuelve a intentarlo"
		puts "La solución fue #{@gameboard.solution.colors}."
	end

	def win
		puts @player_mode ? "\n¡Has resuelto el código! Estupendo!" : "\n
		He resuelto el código, perdón #{@nombre}. A continuación te destruiré!"
	end
end

game = Mastermind.new()
game.play