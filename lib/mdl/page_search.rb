module MDL

  class PageSearch
    attr_reader :search_string, :compounds, :include_misses
    def initialize(search_string: '', compounds: [], include_misses: false)
      @search_string = search_string
      @compounds = compounds
      @include_misses = include_misses
    end

    def results
      return compounds if search_string == ''
      filtered
    end

    def filtered
      activate(compounds.select do |compound|
        sanitize(compound.fetch('transc', '')).include? search_string
      end)
    end

    def activate(compounds)
      compounds.map { |compound| compound.merge('active' => true) }
    end

    def sanitize(val)
      val.class == String ? val : ''
    end

  end
end