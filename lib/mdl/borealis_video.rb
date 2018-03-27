module MDL
  class BorealisVideo <  BorealisAsset

    def src
      "http://cdm16022.contentdm.oclc.org/utils/getstream/collection/#{collection}/id/#{id}"
    end

    def downloads
        []
    end

    def type
      (video_playlist_id) ? 'kaltura_video_playlist' : 'kaltura_video'
    end

    def video_id
      document.fetch('kaltura_video_ssi', false)
    end

    def video_playlist_id
      document.fetch('kaltura_video_playlist_ssi', false)
    end

    def viewer
      MDL::BorealisVideoPlayer
    end

  end
end