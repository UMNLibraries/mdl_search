module MDL
  class BorealisPDF <  BorealisAsset
    def src
      "http://reflections.mndigital.org/utils/getfile/collection/#{collection}/id/#{id}/filename"
    end

    def downloads
      [src: "http://reflections.mndigital.org/utils/getfile/collection/#{collection}/id/#{id}/filename", label: 'Download']
    end

    def to_viewer
      {
        "type" => "pdf",
        "height" => 800,
        "thumbnail" => thumbnail,
        "src" => src,
        "transcript" => {
          "label" => "PDF",
          "texts" => transcripts
        }
      }
    end
  end
end