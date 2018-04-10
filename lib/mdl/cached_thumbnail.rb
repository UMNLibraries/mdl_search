module MDL
  class Thumbnail
    attr_accessor :collection, :id, :cache_dir, :title, :url
    def initialize(collection: :missing_collection,
                   id: :missing_id,
                   cache_dir: File.join(Rails.root, 'thumbnails'),
                   title: '',
                   url: false)
      @collection = collection
      @id         = id
      @cache_dir  = cache_dir
      @title      = title
      @url        = (url) ? url : default_url
    end

    def data
      @data ||= Net::HTTP.get_response(URI(url)).body
    end

    def default_url
      "https://cdm16022.contentdm.oclc.org/utils/getthumbnail/collection/#{collection}/id/#{id}"
    end

    def filename
      "#{collection}_#{id}.jpg"
    end

    def cached?
      File.exists?("#{cache_dir}/#{filename}")
    end

    def save
      File.open("#{cache_dir}/#{filename}", 'wb') { |file| file.write(data)}
    end

    def cached_file
      File.read("#{cache_dir}/#{filename}")
    end
  end
end