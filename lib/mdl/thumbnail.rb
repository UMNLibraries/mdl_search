module MDL
  class Thumbnail
    attr_accessor :collection, :id, :cache_dir, :title, :type
    def initialize(collection: :missing_collection,
                   id: :missing_id,
                   cache_dir: File.join(Rails.root,
                                        'public',
                                        'assets',
                                        'thumbnails'),
                   title: '',
                   type: '')
      @collection = collection
      @id         = id
      @cache_dir  = cache_dir
      @title      = title
      @type       = type
    end

    def thumbnail_url
      case thumbnail_type
      when :sound
        'https://d1kue88aredzk1.cloudfront.net/audio-3.png'
      when :video
        'https://d1kue88aredzk1.cloudfront.net/video-1.png'
      when :contentdm
        "https://cdm16022.contentdm.oclc.org/utils/getthumbnail/collection/#{collection}/id/#{id}"
      end
    end

    def save
      File.open(file_path, 'wb') { |file| file.write(data)}
    end

    def cached?
      File.exists?(file_path)
    end

    def data
      @data ||= Net::HTTP.get_response(URI(thumbnail_url)).body
    end

    def file_path
      "#{cache_dir}/#{filename}"
    end

    def cached_file
      File.read(file_path)
    end

    def filename
      "#{collection}_#{id}.jpg"
    end

    private

    def thumbnail_type
      case type
      when 'Sound Recording Nonmusical'
        :sound
      when 'Moving Image'
        :video
      else
        :contentdm
      end
    end

  end
end