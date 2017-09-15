require 'pry'

class MusicLibraryController
  attr_accessor :files

  def initialize(path = './db/mp3s')
    MusicImporter.new(path).import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    input = ""
    while input != "exit" do
      input = gets.chomp
      if input == "list_songs"
        list_songs
      end
    end
  end

  def list_songs
    Song.all.sort{ |a, b| a.name <=> b.name }.each.with_index(1) do |s, i|
      puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
    end
  end

  def list_artists
    old_files = @files
    binding.pry
    ff = old_files.collect do |f|
      f.split(".")[0]
    end

    f = ff.collect do |f|
      f.split(" - ")[0]
    end

    f = f.uniq

    f = f.sort

    f.each_with_index { |file, index| puts "#{index + 1}. #{file}" }
  end
end
