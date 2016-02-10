# Words Test

## Purpose
This is my solution to the problem described at [https://gist.github.com/pedromartinez/7788650](https://gist.github.com/pedromartinez/7788650).

## Usage
- `rake run[in_words,out_words,out_sequences]` Runs the string processing script. (args default to "dictionary.txt", "words.txt", and "sequences.txt" respectively).
- `rake spec` Run RSpec code examples.
- `rake confirm[words_path,sequences_path]` Utility task to confirm that the output files meets all the requirements. (args default to "words.txt", and "sequences.txt" respectively).

## Considerations

#### Performance
With the size of the provided dictionary, this solution runs quickly enough. However, if the dictionary size increases, a further optimisation could be made. We could keep track of how often a sequence occurs and if it exceeds some commonness threshold, shovel it into a list of "commonly_seen_sequences". By doing a pre-check on this commonly_seen list, the number of harder full seen_sequences checks could be reduced.

Or in pseudo-code:

```
full_sequences = {}
common_sequences = []
for each sequence in sequences
  next if sequence in common_sequences
  if sequence not in full_sequences
    full_sequences[sequence] = 1
  else
    full_sequences[sequence] += 1
    if full_sequences[sequence] > commonness_threshold
      common_sequences << sequence
  // process as usual
```

I _believe_ this would bring a performance improvement, but not so much so with a dictionary of this size. Furthermore, the `commonness_threshold` would need to be tinkered with depending on the size and type of dictionary.

#### Edge cases and considerations
I discovered an edge case that does not exist in the provided dictionary. I wrote a test for it (`doesn't discount duplicate sequences if they occur within the same word`). In the provided dictionary, two possible instances of this exist "couscous" and "beriberi". However, both "beri" and "cous" exist in other words so they are correctly discounted anyway. With a larger dictionary though, this could potentially creep up.
