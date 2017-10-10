module MDL
  class BorealisOpenSeadragon < BorealisAssetsViewer
    attr_accessor :focus

    def type
      'image'
    end

    def to_viewer
      {
        'type' => type,
        'basename' => '',
        'thumbnail' => assets.first.thumbnail,
        'label' => 'Image',
        'include_controls' => true,
        'sequenceMode' => true,
        'showReferenceStrip' => false,
        'defaultZoomLevel' => 0,
        'minZoomLevel' => 0,
        'containerColumns' => 9,
        'sidebarColumns' => 3,
        'tileSources' => assets.map(&:src),
        'transcripts' => assets.map do |img|
          img.transcripts if img.transcripts != ''
        end.flatten.compact.uniq,
        'thumbnails' => assets.map(&:thumbnail),
        'pages' => assets.map(&:title),
        'transcript' => {
          'texts' => assets.map do |img|
            img.transcripts if img.transcripts != ''
          end.flatten.compact.uniq,
          'label' => 'Image'
        }
      }
    end
  end
end