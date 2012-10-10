require "rack"

class RandomRecipes
  def initialize(markov)
    @markov = markov
  end

  def call(env)
    response = Rack::Response.new
    response["Content-Type"] = "text/plain"
    response.write @markov.chain.join(" ")
    response.finish
  end
end
