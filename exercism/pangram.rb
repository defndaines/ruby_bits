class Pangram

  def self.is_pangram?(str)
    str.downcase.gsub(/[^[:alpha:]]/, '').chars.uniq.length >= 26
  end
end

module BookKeeping
  VERSION = 2
end
