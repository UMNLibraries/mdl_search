require_relative '../../../lib/mdl/borealis_asset.rb'
require_relative '../../../lib/mdl/borealis_assets_viewer.rb'
require_relative '../../../lib/mdl/borealis_video_player.rb'
require_relative '../../../lib/mdl/borealis_video.rb'
module MDL
  describe BorealisVideoPlayer do
    let(:video) do
      instance_double('BorealisVideo',
                      type: 'kaltura_video',
                      transcripts: ['A brief history of cat costumes'],
                      thumbnail: 'https://d1kue88aredzk1.cloudfront.net/video-3.png',
                      video_id: 'v568')
    end

    it 'produces a configuration for Videos' do
      expect(video).to receive(:transcripts)
      expect(video).to receive(:video_playlist_id)
      expect(viewer(video)).to be_kind_of(Hash)
      expect(viewer(video)['type']).to eq 'kaltura_video'
      expect(viewer(video)['targetId']).to eq 'kaltura_player_video'
      expect(viewer(video)['wid']).to eq '_1369852'
      expect(viewer(video)['uiconf_id']).to eq 38683631
      expect(viewer(video)['entry_id']).to eq 'v568'
      expect(viewer(video)['transcript']).to eq(
        'texts' => ['A brief history of cat costumes'], 'label' => 'Video'
      )
      expect(viewer(video)['wrapper_height']).to eq '100%'
      expect(viewer(video)['wrapper_width']).to eq '100%'
      expect(viewer(video)['thumbnail']).to eq 'https://d1kue88aredzk1.cloudfront.net/video-1.png'
    end

    def viewer(asset)
      @viewer ||= BorealisVideoPlayer.new(assets: [asset]).to_viewer
    end
  end
end
