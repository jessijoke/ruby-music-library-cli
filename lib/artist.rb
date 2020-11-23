class Artist
    extend Concerns::Findable

    attr_accessor :songs, :name

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
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

    def self.create(artist)
        artist = self.new(artist)
        artist.save
        artist
    end

    def add_song(song)
        song.artist = self unless song.artist == self
        @songs << song unless @songs.include?(song)
    end

    def genres
        genres = @songs.map { |song| song.genre }
        genres.uniq
    end
end