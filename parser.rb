class Parser

  def initialize(sequence_length: 4)
    @sequence_length = sequence_length - 1
  end

  def parse(input_path: "dictionary.txt", words_path: "words.txt", sequences_path: "sequences.txt")
    File.open(input_path, "r") do |in_file|
      sequences_hash = sequences_from_file(in_file)
      dump(sequences_hash, words_path, sequences_path)
    end
  end

  def sequences_from_file(input_file)
    sequence_status = {}
    sequence_words = {}

    input_file.each do |line|
      sequences(line).each do |seq|
        sequence_status[seq] ||= :newly_seen

        if sequence_status[seq] == :newly_seen
          sequence_words[seq] = line
          sequence_status[seq] = :seen_once
        elsif sequence_status[seq] == :seen_once
          sequence_words.delete(seq)
          sequence_status[seq] = :overseen_and_deleted
        end
      end
    end

    sequence_words
  end

  def sequences(line)
    letters = line.gsub(/[^A-Za-z]/, "")
    seqs = []
    i = 0
    while i < letters.length - @sequence_length
      seqs << letters[i .. i + @sequence_length]
      i += 1
    end
    seqs.uniq
  end

  def dump(sequences_hash, words_path, sequences_path)
    File.open(words_path, "w") do |words_file|
      File.open(sequences_path, "w") do |sequences_file|
        sequences_hash.each do |sequence, word|
          sequences_file.puts sequence
          words_file.puts word
        end
      end
    end
  end
end
