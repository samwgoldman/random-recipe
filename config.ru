require "./markov"
require "./random_recipes"

markov = Markov.new
markov.load_bigrams("bigrams.txt")

run RandomRecipes.new(markov)
