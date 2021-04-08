class CubeController < ApplicationController

  def solve
    @initial_state = params[:initial_state] || 'YOWBYBYBOYRRYGROBWGOBRROYWWOGBRWWGOORYRYBYRGGBGBWOGGWW'
    @solution = params[:solution]
  end

  def show
    @solution = params[:solution]
    @steps = @solution.split(' ').count if @solution
    @cube_params = "alg=#{@solution}|flags=showalg"
  end

end
