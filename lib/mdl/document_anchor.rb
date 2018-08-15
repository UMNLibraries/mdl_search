module MDL
  class DocumentAnchor
    attr_reader :doc, :search_text, :document_klass
    def initialize(doc: {}, search_text: false, document_klass: BorealisDocument)
      @doc = doc
      @search_text = search_text
      @document_klass = document_klass
    end

    def anchor
      case document_klass.new(document: doc).first_key
      when 'image'
        initial_path = "/image/0#{search}"
      when 'kaltura_video'
        initial_path = '/kaltura_video'
      when 'kaltura_audio'
        initial_path = '/kaltura_audio'
      when 'pdf'
        initial_path = '/pdf/0'
      else
        initial_path = ''
      end
    end

    def search
      "?searchText=#{search_text}" if search_text
    end
  end
end