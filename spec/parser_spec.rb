require "./parser"

describe Parser do

  before do
    @parser = Parser.new
  end

  describe "sequences_from_file" do

    it "gives back unique sequences and the words that they came from" do
      in_file = ["arrows", "carrots", "give", "me"]
      hash = @parser.sequences_from_file(in_file)
      sorted = hash.sort_by {|k,v| k}
      expected_result = [
        ["carr", "carrots"],
        ["give", "give"],
        ["rots", "carrots"],
        ["rows", "arrows"],
        ["rrot", "carrots"],
        ["rrow", "arrows"],
      ]
      expect(sorted).to eql(expected_result)
    end

    it "doesn't discount duplicate sequences if they occur within the same word" do
      unique_occurrence = @parser.sequences_from_file(["abcdef", "boofandboof", "vwxyz"])
      expect(unique_occurrence.keys).to include("boof")

      non_unique_occurrence = @parser.sequences_from_file(["aboofz", "boofandboof"])
      expect(non_unique_occurrence.keys).to_not include("boof")
    end
  end

  describe "sequences" do

    it "strips non-letters" do
      expect(@parser.sequences("a'B1c-D")).to eql(["aBcD"])
    end

    it "includes all sequences but no duplicates" do
      expect(@parser.sequences("foofoof")).to eql(["foof", "oofo", "ofoo"])
    end
  end
end
