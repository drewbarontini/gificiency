require 'net/http'
require 'json'

# ====================================
#   Gificiency
# ====================================

class Gificiency

  # Constructor
  #
  # == Parameters
  #
  # == Usage
  #
  #   Gificiency.new
  #
  def initialize
    @gifs          = {}
    @categories    = []
    @category_gifs = []
    @response      = get_json
    @gifs          = JSON.parse(@response.body, symbolize_names: true)

    set_categories
  end

  # Get JSON
  #
  # == Usage
  #
  #   get_json
  #
  def get_json
    Net::HTTP.get_response('gificiency.com', '/gifs.json')
  end

  # Gets the category from the string
  #
  # == Parameters
  #
  # @param string [String] the category string
  #
  # == Usage
  #
  #   get_category('category-name.gif')
  #
  def get_category(string)
    string.to_s.split('-')[0]
  end

  # Gets the category from an unprefixed string
  #
  # == Parameters
  #
  # @param string [String] the category string
  #
  # == Usage
  #
  #   get_category('name.gif')
  #
  def get_categoryless_gif(string)
    string.to_s.split('.')[0]
  end

  # Get all the unique categories
  #
  # == Usage
  #
  #   get_categories
  #
  def get_categories
    @categories.uniq.join(', ')
  end

  # Set the categories
  #
  # == Usage
  #
  #   set_categories
  #
  def set_categories
    @categories = @gifs.map do |gif|
      unless gif[:category] == nil
        get_category( gif[:category] )
      end
    end
  end

  # Get the GIFs based on a category
  #
  # == Parameters
  #
  # @param category [String] the category
  #
  # == Usage
  #
  #   get_category_gifs('angry')
  #
  def get_category_gifs(category)
    category_gifs = []

    @gifs.each do |gif|
      unless gif[:category] == nil
        if gif[:category] == category
          category_gifs << gif
        end
      else
        if get_categoryless_gif( gif[:name] ) == category
          return gif
        end
      end
    end

    category_gifs
  end

  # Get a random GIF
  #
  # == Usage
  #
  #   get_random_gif
  #
  def get_random_gif
    @gifs.sample[:url]
  end

  # Get a random GIF by category
  #
  # == Parameters
  #
  # @param category [String] the category
  #
  # == Usage
  #
  #   get_random_gif_by_category('dealwithit')
  #
  def get_random_gif_by_category(category)
    gif_set = get_category_gifs(category)

    if gif_set.kind_of?(Array)
      unless gif_set.empty?
        gif_set.sample[:url]
      else
        'No GIF found.'
      end
    else
      gif_set[:url]
    end
  end
end

# gificiency = Gificiency.new
# puts gificiency.get_random_gif_by_category('sad')
# puts gificiency.get_categories
