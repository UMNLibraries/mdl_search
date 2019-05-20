module MDL
  class BorealisAssetsToViewers
    attr_reader :assets
    def initialize(assets: [])
      @assets          = assets
    end

    def viewers
      grouped_assets.map do |klass, assets|
        to_viewer(assets.first, assets)
      end.reduce({}, :merge)
    end

    private

    # Convert a set of assets into a viewer
    #
    # A viewer is a single thing that is comprised of one or more assets.
    # Naming conventions and class model could be a *lot* better here.
    #
    # Each asset knows what kind of viewer it belongs to. So, once we have
    # a list of assets (see grouped_assets below), grab the first asset,
    # instantiate its viewer, and convert the list of assets to a viewer
    def to_viewer(asset, assets)
      {
        asset.type => asset.viewer.new(assets: assets).to_viewer
      }
    end


    # Sort assets into a hash keyed by asset type
    #
    # Compound items can have different kinds of children - videos, images, etc
    # React Borealis expects to get a json object brokent down into these
    # different kinds of things. e.g.:
    # {
    #   "image" => {type"=>"image", "tileSources"=>["info?id=p1...
    #   "kaltura_video" => {"type"=>"kaltura_video", "targetId"=>"blah"...
    # }
    def grouped_assets
      assets.group_by { |asset| asset.class }
    end
  end
end