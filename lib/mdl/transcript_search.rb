module MDL
  class TranscriptSearch
    attr_reader :transcripts, :search_text
    def initialize(transcripts: [], search_text: '')
      @transcripts = transcripts
      @search_text = search_text
    end

    def page
      (search == nil) ? 0 : search
    end

    def search
      @search ||= transcripts.find_index { |transc| transc.include? search_text }
    end
  end
end