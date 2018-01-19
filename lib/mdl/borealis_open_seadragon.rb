module MDL
  class BorealisOpenSeadragon < BorealisAssetsViewer
    attr_accessor :focus

    def type
      'image'
    end

    def pages
      assets.map.with_index do |page, id|
        page.to_h.merge(
          'id' => id,
          'viewer' => 'OSD_VIEWER',
          'cdmCollection' => page.collection,
          'cdmIdentifier' => page.id,
          'sidebarThumbnail' => page.thumbnail,
          'infoURL' => ['https://cdm16022.contentdm.oclc.org/digital/iiif/',
                        "#{page.collection}/#{page.id}/",
                        'info.json'].join
        )
      end
    end

    def to_viewer
      {
        'viewerColumnsSmall' => 'col-md-8',
        'sidebarColumnsLarge' => 'col-md-4',
        'viewerColumnsLarge' => 'col-md-9',
        'sidebarColumnsSmall' => 'col-md-3',
        'type' => type,
        'basename' => 'image',
        'thumbnail' => assets.first.thumbnail,
        'label' => 'Image',
        'transcripts' => assets.map do |img|
          img.transcripts if img.transcripts != ''
        end.flatten.compact.uniq,
        'osdConfig' => {
          'setStrings' => [{name: 'Tooltips.Home', value: 'Reset'}],
          'include_controls' => true,
          'sequenceMode' => true,
          'showReferenceStrip' => false,
          'defaultZoomLevel' => 0,
          'tileSources' => assets.map(&:src),
        },
        'getImageURL' => 'http://cdm16022.contentdm.oclc.org/utils/ajaxhelper',
        'pages' => pages,
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