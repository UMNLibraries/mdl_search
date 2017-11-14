module MDL
  class BorealisAsset
    attr_reader :id, :collection, :transcripts, :title, :document, :assets
    attr_accessor :focus
    def initialize(id: '',
                   collection: '',
                   transcript: false,
                   title: false,
                   document: {},
                   assets: [])
      @id           = id
      @collection   = collection
      @transcripts  = [sanitize_field(transcript)].compact
      @title        = sanitize_field(title)
      @document     = document
      @assets       = assets
    end

    def to_h
      {
        id: id,
        collection: collection,
        transcripts: transcripts,
        transcript: transcripts.join("\n"),
        title: title,
        assets: assets,
        thumbnail: thumbnail
      }
    end

    def thumbnail
      "/thumbnails/#{collection}:#{id}"
    end

    def iiif_compatable?
      false
    end

    def type
      :missing_type
    end

    private

    def sanitize_field(field)
      (field == {} || field == false || field == '') ? nil : field
    end
  end
end