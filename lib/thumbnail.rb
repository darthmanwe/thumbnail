require "thumbnail/version"
require "thumbnail/methods"
require "hashr"
require "open4"

Hashr.raise_missing_keys = true

module Thumbnail
  class ImageMagickError < Exception; end
  class InvalidMethod < Exception; end
  class << self
    #
    # Identify the width, height, format and depth of the image.
    #
    def identify(file, options={})
      defaults = { :cmd => 'identify' }
      config = Hashr.new(options, defaults)
      cmd = %Q{#{config.cmd} "#{file}"}
      status, stdout = execute(cmd)
      format, geometry, depth = stdout.scan(/([A-Z]+) (.+) .+ (\d+)-bit/)[0]
      width, height = geometry.split('x')
      { :width  => width.to_i,
        :height => height.to_i,
        :format => format.downcase.to_sym,
        :depth  => depth.to_i }
    end
    #
    # Create a thumbnail
    #
    def create(options={})
      defaults = { :method => 'cut_to_fit', :gravity => 'center', :cmd => 'convert', :smush => false }
      config = Hashr.new(options, defaults)
      method = config[:method]
      raise_unknown_method(method) unless Methods.respond_to?(method)  
      parameters = Methods.send(method, config)
      cmd = %Q{#{config.cmd} #{config.in} #{parameters} #{make_path(config.out)}}
      status, stdout = execute(cmd)
      Smusher.optimize_image(config.out) if config.smush
      config.out
    end
  protected
    #
    # Execute a command
    #
    def execute(cmd)
      pid, stdin, stdout, stderr = Open4::popen4("#{cmd} 2>&1") # Redirect stderr to stdout
      _, status = Process::waitpid2(pid)
      raise ImageMagickError, "'#{cmd.gsub(/\s+/, ' ')}' exited with status #{status}. Details:\n\n#{stdout}" if status != 0
      [status, stdout.read.strip]
    end
    #
    # Create a directory
    #
    def make_path(path)
      dir = File.dirname(path)
      FileUtils.mkdir_p(dir)
      path
    end
    #
    # Prints valid methods and raises an error
    #
    def raise_unknown_method(method)
      valid = Methods.methods(false).sort
      message = "Unknown method '#{method}'. Valid methods are #{valid.join(', ')}."
      raise InvalidMethod, message
    end
  end
end
