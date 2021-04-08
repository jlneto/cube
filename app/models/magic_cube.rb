class MagicCube

	# THIS GEM IS TO SLOW, CAN NOT SOLVE COMPLEX CUBES, RETURN NO ERROR MESSAGES! DO NOT USE
	# require 'rubiks_cube'
	#
	# def initialize(cube_state)
	# 	@cube = RubiksCube::Cube.new
	# 	@cube.state = cube_state
	# end
	#
	# def perform(movements)
	# 	@cube.perform! movements
	# end
	#
	# def solve
	# 	solution = RubiksCube::TwoCycleSolution.new(@cube).solution
	# 	solution = solution - [""]
	# 	solution.join(' ')
	# end

	def self.samples
		s = []
		s << ['YOWBYBYBOYRRYGROBWGOBRROYWWOGBRWWGOORYRYBYRGGBGBWOGGWW',"U' D2 L F' L' B U R' F L2 F2 U2 D F2 U F2 L2 U B2 D' F2 B2 R2"]
		s << ["GRWWYGRBWORGYGGRWOWYBBROGGYYYBYWRYOGRGBBBOORORBYOOWWWB","F R2 D2 F2 D L U L F R U' B2 R2 U' L2 D L2 U L2 U2 R2 L2 F2 L2"]
		s << ["BBRBYRRYOGWBWGBWGWGRYGRGBWBYBOYWOGOOORWRBYYORWOYYOGGWR","R2 F' D' B2 R' U' B' R' F' R F2 U' L2 D2 R2 B2 D' B2 U' B2 D' L2 U'"]
		s << ["RORYYYOBBYGWGGBBWWBYRWRRGYWYRRRWBOOOYOWGBOBWOGGGROWGBY","R B2 L' F R' U' D L D R2 U' L2 F2 D L2 F2 D F2 R2 D L2 U"]
		s
	end

end