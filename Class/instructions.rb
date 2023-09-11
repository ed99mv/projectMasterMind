class Instructions
    def instructions
		puts "_________________________________________________________\n\n" 
	    print "Ingresa tu nombre: "
		@nombre = gets.chomp
		puts "Hola #{@nombre} bienvenido al juego MasterMind"
		puts "Adivina el codigo!"
		@gameboard.display
		puts "_________________________________________________________\n\n"
		puts "Verde para cada color en la posición correcta."
		puts "Roja para cada color en una posición incorrecta!" 
		puts "\nBuena Suerte #{@nombre}!"
		puts "_________________________________________________________\n\n"
	end
end
