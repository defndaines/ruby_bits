class Sieve

  def initialize(n)
    @n = n
  end

  def primes
    to_check = (2..@n).to_a
    vals = []
    while not to_check.empty?
      i = to_check.shift
      vals << i
      to_check.select! { |n| n % i != 0 }
    end
    vals
  end
end
