require_relative '../gificiency'

describe Gificiency do

  before(:each) do
    @gificiency = Gificiency.new
  end

  describe '#initialize' do
    it 'should instantiate a new Gificiency object' do
      expect(@gificiency).to be_an_instance_of(Gificiency)
    end
  end

  describe '#get_categories' do
    it 'should return the list of unique categories' do
      categories = @gificiency.get_categories

      expect(categories.length).to be > 0
    end
  end

  def self.get_category_gif_test(category)
    it "should get a random #{ category } GIF" do
      gif = @gificiency.get_random_gif_by_category(category)

      expect(gif).to match("http:\/\/gificiency\.com\/m\/#{ category }-*.")
    end
  end

  describe '#get_random_gif_by_category' do
    self.get_category_gif_test('angry')
    self.get_category_gif_test('sad')
    self.get_category_gif_test('highfive')
    self.get_category_gif_test('dealwithit')
  end

  describe '#get_random_gif' do
    it 'should grab a random GIF' do
      gif = @gificiency.get_random_gif

      expect(gif).to match("http:\/\/gificiency\.com\/m\/*.")
    end
  end
end

