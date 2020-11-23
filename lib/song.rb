class Song
    attr_accessor :artist, :name, :genre

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def name
        @name
    end

    def name=(name)
        @name = name
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all = []
    end

    def save
        @@all << self
    end

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    def artist
        @artist
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre
        @genre
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.find_by_name(name)
        self.all.detect {|song| song.name == name }
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(filename)
        name = filename.split(" - ")
        name[2] = name[2].delete_suffix('.mp3')
        song_artist = name[0]
        song_name = name[1]
        song_genre = name[2]
        song = self.find_or_create_by_name(song_name)
        song.artist = Artist.find_or_create_by_name(song_artist)
        song.genre = Genre.find_or_create_by_name(song_genre)
        song
    end

    def self.create_from_filename(filename)
        song = new_from_filename(filename)
        song.save
    end
end