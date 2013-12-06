module Thumbnail
  module Methods
    class << self
      #
      # Resizes the thumbnail to fit inside specified dimensions 
      # while retaining aspect ratio. Adds transparent padding if 
      # thumbnail doesn't cover specified dimension.
      #
      # Reference (Pad out the thumbnail):
      # http://www.imagemagick.org/Usage/thumbnails/#fit_summery
      #
      def pad_to_fit(options)
        %Q{-thumbnail #{options.width}x#{options.height}> \
           -transparent \
           -gravity #{options.gravity} \
           -unsharp 0x.5 \
           -auto-orient \
           -extent #{options.width}x#{options.height}}
      end
      #
      # Resizes the thumbnail to fit inside specified dimensions 
      # while retaining aspect ratio.
      #
      # Reference (Cut the thumbnail to fit):
      # http://www.imagemagick.org/Usage/thumbnails/#cut_summery
      #
      def cut_to_fit(options)
        %Q{-thumbnail #{options.width}x#{options.height}^ \
           -gravity #{options.gravity} \
           -unsharp 0x.5 \
           -auto-orient \
           -extent #{options.width}x#{options.height}}
      end
    end
  end
end
