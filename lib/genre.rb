class Genre
    extend Concerns::Findable

    attr_accessor :name, :songs

    def initialize(name, genre=nil)
        @name = name
        @songs = []
        @genre = genre
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

    def self.create(genre)
        genre = self.new(genre)
        genre.save
        genre
    end

    def songs
        @songs
    end

    def artists
        artists = @songs.map { |song| song.artist }
        artists.uniq
    end
end