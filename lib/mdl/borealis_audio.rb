module MDL
  class BorealisAudio < BorealisAsset

    def downloads
        []
    end

    def viewer
      MDL::BorealisAudioPlayer
    end

    def type
      (audio_playlist_id) ? 'kaltura_audio_playlist' : 'kaltura_audio'
    end

    def audio_playlist_id
      document.fetch('kaltura_audio_playlist_ssi', false)
    end

    def audio_id
      document.fetch('kaltura_audio_ssi', false)
    end
  end
end