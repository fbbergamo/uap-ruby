# frozen_string_literal: true

module UserAgentParser
  class Version

    # Private: Regex used to split string version string into major, minor,
    # patch, and patch_minor.
    SEGMENTS_REGEX = /\d+\-\d+|\d+[a-zA-Z]+$|\d+|[A-Za-z][0-9A-Za-z-]*$/

    attr_reader :version
    alias :to_s :version

    def initialize(*args)
      if args.length == 1 && args.first.is_a?(String)
        @version = args.first.to_s.strip
      else
        @segments = args.map(&:to_s).map(&:strip)
        @version = segments.join('.')
      end
    end

    def major
      segments[0]
    end

    def minor
      segments[1]
    end

    def patch
      segments[2]
    end

    def patch_minor
      segments[3]
    end

    def inspect
      "#<#{self.class} #{to_s}>"
    end

    def eql?(other)
      self.class.eql?(other.class) &&
        version == other.version
    end

    alias_method :==, :eql?

    # Private
    def segments
      @segments ||= version.scan(SEGMENTS_REGEX)
    end
  end
end
