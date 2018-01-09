module MDL
  class BorealisImagePath
    attr_reader :titles, :transcripts, :search_text, :transcript_search_klass
    def initialize(transcripts: [],
                   titles: [],
                   search_text: '',
                   transcript_search_klass:  MDL::TranscriptSearch)
      @titles = titles
      @transcripts = transcripts
      @search_text = search_text
      @transcript_search_klass = transcript_search_klass
    end

    def search
      (search_text != '') ? "?searchText=#{search_text}" : ''
    end

    def path
      "image/#{page}#{search}"
    end

    def texts
      titles.zip(transcripts).map { |item| item.join(' ') }
    end

    def page
      transcript_search_klass.new(transcripts: texts,
                                  search_text: search_text).page
    end
  end
end