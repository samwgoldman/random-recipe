class Markov
  attr_reader :bigrams, :bigram_totals

  def initialize
    @bigrams = {}
    @bigram_totals = Hash.new(0)
  end

  def load_bigrams(filename)
    File.open(filename) do |file|
      file.each_line do |line|
        words, count = line.split("\t")
        a, b = words.split(" ")
        count = count.to_i

        bigram_totals[a] += count

        bigrams[a] ||= Hash.new(0)
        bigrams[a][b] += count
      end
    end
  end

  def sample(from)
    r = rand(bigram_totals[from]) + 1
    acc = 0
    bigrams[from].each do |word, freq|
      acc += freq
      return word if acc >= r
    end
    nil
  end

  def chain
    from = "<S>"
    chain = []
    loop do
      from = sample(from)
      break if from == "</S>"
      chain << from
    end
    chain
  end
end
