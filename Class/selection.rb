class Selection
	def prompt_switch_mode
		puts "¿#{@nombre} quieres jugar tú o quieres que juegue la computadora?"
		mode = gets.chomp
		until mode == "computadora" || mode == "yo"
			mode = gets.chomp
		end
		puts ""
		@player_mode = false if mode == "computadora"
	end
end