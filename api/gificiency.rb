require 'net/http'
require 'json'

class Gificiency

  def initialize
    @gifs = {}
    @categories = []
    @category_gifs = []

    @response = get_json
    @gifs = JSON.parse(@response.body, symbolize_names: true)

    set_categories
  end

  def get_category(string)
    string.to_s.split('-')[0]
  end

  def get_categoryless_gif(string)
    string.to_s.split('.')[0]
  end

  def get_categories
    @categories.uniq.join(', ')
  end

  def set_categories
    @gifs.each do |gif|
      unless gif[:category] == nil
        @categories << get_category( gif[:category] )
      end
    end
  end

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

  def get_json
    Net::HTTP.get_response('gificiency.com', '/gifs.json')
  end

  def get_random_gif
    @gifs.sample[:url]
  end

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
