module MDL
  class BorealisVideoPlayer < BorealisAssetsViewer
    def to_viewer
      (asset.video_playlist_id) ? playlist : player
    end

    def player
      {
        'type' => asset.type,
        'targetId' => 'kaltura_player_video',
        'wid' => '_1369852',
        'uiconf_id' => 38683631,
        'transcript' => {
          'texts' => asset.transcripts,
          'label' => 'Video',
        },
        'entry_id' => asset.video_id,
        'wrapper_height' => '100%',
        'wrapper_width' => '100%',
        'thumbnail' => "https://d1kue88aredzk1.cloudfront.net/video-1.png"
      }
    end

    def playlist
      {
        'type' => 'kaltura_video_playlist',
        'targetId' => 'kaltura_player_playlist',
        'wid' => '_1369852',
        'uiconf_id' => 38719361,
        'flashvars' => {
          'streamerType' => 'auto',
          'playlistAPI.kpl0Id' => asset.video_playlist_id,
        },
        'transcript' => {
          'texts' => asset.transcripts,
          'label' => 'Video Playlist',
        },
        'wrapper_height' => '100%',
        'wrapper_width' => '100%',
        'thumbnail' => "https://d1kue88aredzk1.cloudfront.net/audio-3.png"
      }
    end
  end
end