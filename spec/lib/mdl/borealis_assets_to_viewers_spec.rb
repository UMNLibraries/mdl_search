# require_relative '../../../lib/mdl/borealis_assets_viewer.rb'
# require_relative '../../../lib/mdl/borealis_asset.rb'
# require_relative '../../../lib/mdl/borealis_image.rb'
# require_relative '../../../lib/mdl/borealis_video.rb'
# require_relative '../../../lib/mdl/borealis_video_player.rb'
# require_relative '../../../lib/mdl/borealis_open_seadragon.rb'
# require_relative '../../../lib/mdl/borealis_asset_to_viewer.rb'
# require_relative '../../../lib/mdl/borealis_assets_to_viewers.rb'

# module MDL
#   describe BorealisAssetsToViewers do
#     let(:images) do
#       [
#         MDL::BorealisImage.new(collection: 'images',
#                                id: 1,
#                                title: 'blah',
#                                transcript: 'Image One'),
#         MDL::BorealisImage.new(collection: 'images',
#                                id: 2,
#                                title: 'blah',
#                                transcript: 'Image Two')
#       ]
#     end

#     it 'produces a configuration for Images (OpenSeadragon)' do
#       expect(to_viewers(images)).to eq(
#         {"image"=>{"viewerColumnsSmall"=>"col-xs-12 col-sm-8", "sidebarColumnsLarge"=>"col-xs-12 col-sm-4", ".../iiif/images/2/info.json"}], "transcript"=>{"texts"=>["Image One", "Image Two"], "label"=>"Image"}}}
#       )
#     end

#     def to_viewers(assets)
#       MDL::BorealisAssetsToViewers.new(assets: assets).viewers
#     end
#   end
# end
