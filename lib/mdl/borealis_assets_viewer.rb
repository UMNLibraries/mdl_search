module MDL
  class BorealisAssetsViewer
    attr_reader :assets
    def initialize(assets: [])
      @assets = [assets].flatten
    end

    def asset
      assets.first
    end
  end
end