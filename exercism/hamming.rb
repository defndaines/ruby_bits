class Hamming

  def self.compute(left, right)
    raise ArgumentError, 'Unequal lengths' if left.length != right.length
    dist = 0
    left.split('').zip(right.split('')).each do |l, r|
      dist += 1 if (l != r)
    end
    dist
  end
end

module BookKeeping
  VERSION = 3
end