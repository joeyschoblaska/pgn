require 'spec_helper'

describe PGN do
  describe "parsing a file" do
    it "should return a list of games" do
      games = PGN.parse(File.read("./examples/immortal_game.pgn"))
      games.length.should == 1
      game = games.first
      game.result.should == "1-0"
      game.tags["White"].should == "Adolf Anderssen"
      game.moves.last.should == "Be7#"
    end
  end

  context "alternate castling notation" do
    describe "parsing a file" do
      it "should return a list of games" do
        games = PGN.parse(File.read("./spec/pgn_files/alternate_castling.pgn"))
        game = games.first
        game.tags["White"].should == "Somebody"
        game.result.should == "*"
        game.moves.last.should == "O-O-O"
      end
    end
  end

  context "annotations" do
    describe "parsing a file" do
      it "should return a list of games" do
        games = PGN.parse(File.read("./spec/pgn_files/annotations.pgn"))
        games.each do |game|
          game.tags["White"].should == "Fool"
          game.result.should == "0-1"
          game.moves.last.should == "Qh4#"
        end
      end
    end

    describe "parsing a file" do
      it "should work with comments" do
        games = PGN.parse(File.read("./spec/pgn_files/comments.pgn"))
        game = games.first
        game.tags["White"].should == "Scholar"
        game.result.should == "1-0"
        game.moves.last.should == "Qxf7#"
      end

      it "should work with multiline comments" do
        games = PGN.parse(File.read("./spec/pgn_files/multiline_comments.pgn"))
        game = games.first
        game.tags["White"].should == "Scholar"
        game.result.should == "1-0"
        game.moves.last.should == "Qxf7#"
      end
    end

    describe "parsing a file" do
      it "should return a list of games" do
        games = PGN.parse(File.read("./spec/pgn_files/variations.pgn"))
        game = games.first
        game.tags["Black"].should == "Petrov"
        game.result.should == "*"
        game.moves.last.should == "Nf6"
      end
    end
  end
end
