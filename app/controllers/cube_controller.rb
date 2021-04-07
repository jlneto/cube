class CubeController < ApplicationController
  def show
    @solution = params[:solution]
    @steps = @solution.split(' ').count
    @cube_params = "alg=#{@solution} D>>|hover=4|speed=50|pov=Fdl"
  end

  def setup
    @example = <<-STATE
R G O R G O O W G
G W W B Y W Y Y Y
G B B G B W R Y B
Y G Y B W G R Y W
O R R O R O G Y W
B R O R O O W B B
    STATE
  end

  def solve
    initial_state = params[:initial_state]
    cube = MagicCube.new(initial_state)
    solution = cube.solve
    redirect_to action: :show, solution: solution
  end
end
