class CubeController < ApplicationController

  def setup
    @example = MagicCube.samples[0][0]
    @initial_state = params[:initial_state] || @example
    @solution = params[:solution]
  end

  def show
    @solution = params[:solution]
    @steps = @solution.split(' ').count
    @cube_params = "alg=#{@solution}"
  end

end
