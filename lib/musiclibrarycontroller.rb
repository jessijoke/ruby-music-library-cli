require "pry"

class MusicLibraryController
    def initialize(path='./db/mp3s')
        @path = path
        MusicImporter.new(path).import
    end

    def call
        input = ""
        
        while input != "exit"
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
            input = gets.strip.to_s.downcase

            case input
                when "list songs"
                    list_songs
                when "list artists"
                    list_artists
                when "list genres"
                    list_genres
                when "list artist"
                    list_songs_by_artist
                when "list genre"
                    list_songs_by_genre
                when "play song"
                    play_song
            end
        end
    end

    def list_songs
        #binding.pry
        #song_list = []
        #Song.all.each { |song| song_list << song.name }
        #song_list.each_with_index{|song, i| puts "#{i+1}. #{song}"}

        #songs = Song.all
        #puts sorted_songs
        #songs.each_with_index { |song, index| 
        # puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        #}

        #Song.all.sort{|a, b| a.name <=> b.name}.each_with_index do |s, i|
        #    puts "#{i+1}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
        #end

        #all_songs = Song.all.sort { |a, b| a.name <=> b.name }
        #all_songs.each { |song| puts song.name }

        #--------

        Song.all.uniq.sort { |a, b| a.name <=> b.name }.each.with_index(1) { |song, index| 
            puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            #puts index.to_s + ". " + song.artist.name + " - " + song.name + " - " + song.genre.name
        }
    end

    def list_artists
        Artist.all.uniq.sort { |a, b| a.name <=> b.name }.each.with_index(1) { |artist, index| 
            puts "#{index}. #{artist.name}"
            #puts index.to_s + ". " + song.artist.name + " - " + song.name + " - " + song.genre.name
        }
    end

    def list_genres
        Genre.all.uniq.sort { |a, b| a.name <=> b.name }.each.with_index(1) { |genre, index| 
            puts "#{index}. #{genre.name}"
            #puts index.to_s + ". " + song.artist.name + " - " + song.name + " - " + song.genre.name
        }
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist_input = gets.strip
        artist_songs = Song.all.select { |song| song.artist.name == artist_input }.uniq.sort { |a, b| a.name <=> b.name }
        artist_songs.each.with_index(1) { |song, index|
            puts "#{index}. #{song.name} - #{song.genre.name}"
        }
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre_input = gets.strip
        genre_songs = Song.all.select { |song| song.genre.name == genre_input }.uniq.sort { |a, b| a.name <=> b.name }
        genre_songs.each.with_index(1) { |song, index|
            puts "#{index}. #{song.artist.name} - #{song.name}"
        }
    end

    def play_song
        puts "Which song number would you like to play?"
        song_input = gets.strip.to_i
        if (1..Song.all.length).include?(song_input)
            song = Song.all.uniq.sort{ |a, b| a.name <=> b.name }[song_input - 1]
        end
      
        puts "Playing #{song.name} by #{song.artist.name}" if song
    end

    
end

