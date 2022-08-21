require 'discogs'
require 'id3tag'
require 'set'
require 'pp'

class AlbumFinder
    attr_accessor :artists_years
    
    def initialize
        @artists_years = {}
    end

    def find_file_data        
        Dir.glob("e:/Music/**/*").select { |filename| filename =~ /\.mp3$/i && File.file?(filename)}.each do |file|
            # puts file
            ID3Tag.read(File.open(file, "rb")) do |tag|
                unless tag.nil? && tag.artist.nil? && tag.year.nil? && tag.year.empty?
                    year = tag.year.match(/^(\d{4})/)
                    unless year == nil
                        # enc_artist = tag.artist.force_encoding("utf-8")
                        unless @artists_years.empty? 
                            found_artist = @artists_years.keys.select {|a| a.upcase == tag.artist.upcase} 
                        else
                            found_artist = nil
                        end
                        if found_artist.nil? || found_artist.empty? || @artists_years[tag.artist.upcase] == nil
                            # puts "not found"
                            @artists_years[tag.artist.upcase] = Set.new.add(year.captures.first)
                        else
                            # puts tag.artist
                            # @artists_years.keys.each {|x| puts x}
                            # pp @artists_years[tag.artist.upcase]
                            unless year.nil?
                                # pp year.captures.first
                                @artists_years[tag.artist.upcase].add(year.captures.first)
                            end
                        end
                    end
                end
            end
        end
    end

    def print_artists
        artists_years.each do |artist, years|
            years.each do |year|
                puts "#{artist} - #{year}"
            end
        end
    end

    def print_all
        pp artists_years
    end
end

s = Set.new.add(1)
af = AlbumFinder.new

af.find_file_data()
af.print_all