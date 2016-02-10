require "rspec/core/rake_task"
require "benchmark"
require "./parser"

RSpec::Core::RakeTask.new(:spec)
task :test => :spec
task :default => :spec

desc "Runs the string processing script"
task :run, [:in_words, :out_words, :out_sequences] do |t, args|
  Benchmark.bm do |bm|
    bm.report do
      in_words_path = args[:in_words] || "dictionary.txt"
      out_words_path = args[:out_words] || "words.txt"
      out_sequences_path = args[:out_sequences] || "sequences.txt"

      Parser.new.parse(input_path: in_words_path, words_path: out_words_path, sequences_path: out_sequences_path)
    end
  end
end

desc "Utility task to confirm that the output files meet all the requirements"
task :confirm, [:words_path, :sequences_path] do |t, args|
  words_path = args["words_path"] || "words.txt"
  sequences_path = args["sequences_path"] || "sequences.txt"

  bad = []
  words = File.read(words_path).gsub(/[^A-Za-z\n]/, "").split("\n").uniq.join("\n")
  File.open(sequences_path, "r").each do |line|
    splits = words.split(line.strip)
    if splits.count > 2 && splits[1].include?("\n")
      bad << line.strip
    end
  end
  if bad.any?
    puts "bad sequences to check out: #{bad.join(', ')}"
  else
    puts "it checks out"
  end
end
