class Raindrops

  DROPS = { 3 => 'Pling', 5 => 'Plang', 7 => 'Plong' }

  def self.convert(n)
    sound = DROPS.map { |k, v| n % k == 0 ? v : '' }.join
    sound.empty? ? n.to_s : sound
  end
end

module BookKeeping
  VERSION = 2
end
