class Complement

  @@rna = { 'A' => 'U', 'C' => 'G', 'G' => 'C', 'T' => 'A' }

  def self.of_dna(strand)
    transcription = strand.split('').map { |c| @@rna[c] }.join
    if transcription.length == strand.length
      transcription
    else
      ''
    end
  end
end

module BookKeeping
  VERSION = 4
end