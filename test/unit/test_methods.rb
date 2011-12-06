require 'test_helper'

class TestMethods < Test::Unit::TestCase
  def test_gif
    assert_equal "tmp/images/image.gif", Thumbnail.create(
      :in => 'test/images/image.jpg', 
      :out => 'tmp/images/image.gif',
      :width => 202,
      :height => 203
    )
    meta = Thumbnail.identify('tmp/images/image.gif')
    assert_equal({:height=>203, :format=>:gif, :width=>202, :depth=>8}, meta)
  end
  def test_pad_to_fit
    assert_equal "tmp/images/image.png", Thumbnail.create(
      :method => :pad_to_fit,
      :in => 'test/images/image.jpg', 
      :out => 'tmp/images/image.png',
      :width => 202,
      :height => 203
    )
    meta = Thumbnail.identify('tmp/images/image.png')
    assert_equal({:height=>203, :format=>:png, :width=>202, :depth=>8}, meta)
  end
  def test_cut_to_fit
    assert_equal "tmp/images/image.png", Thumbnail.create(
      :method => :cut_to_fit,
      :in => 'test/images/image.jpg', 
      :out => 'tmp/images/image.png',
      :width => 102,
      :height => 103
    )
    meta = Thumbnail.identify('tmp/images/image.png')
    assert_equal({:height=>103, :format=>:png, :width=>102, :depth=>8}, meta)
  end
  def test_invalid_method
    assert_raises Thumbnail::InvalidMethod do 
      Thumbnail.create(:method => :jebus)
    end
  end
  def test_missing_parameters
    assert_raises IndexError do 
      Thumbnail.create(
        :in => 'test/images/image.jpg', 
        :out => 'tmp/images/image.png',
        :height => 203
      )
    end
  end
end
