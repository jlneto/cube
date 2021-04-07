class MagicCube

	require 'rubiks_cube'

	def initialize(cube_state)
		@cube = RubiksCube::Cube.new
		@cube.state = cube_state
	end


	def perform(movements)
		@cube.perform! movements
	end

	def solve
		solution = RubiksCube::TwoCycleSolution.new(@cube).solution
		solution = solution - [""]
		solution.join(' ')
	end

end