require 'json'
module MdlCatalogViewHelper

  def render_asset_viewer(item)
    render "catalog/viewers/#{item.viewer}", item: item, js: false
  end

  def desolerize(document)
    document = document.transform_keys{ |key| key.gsub(/_([a-z])*$/, '').to_sym }.symbolize_keys
    if document[:compound_objects]
      document[:compound_objects] = Array.wrap(JSON.parse(document[:compound_objects])).map(&:symbolize_keys)
    end
    document
  end

  private


  def compounds(document)
    MDL::CompoundAsset.new(desolerize(document))
  end

  # TODO: include id and collection in the contentdm extractor for each compound item
  # And remove adding it here
  def compounds_with_identifiers(document)
    collection, id = identifiers(document)
    compound_items(document).map { |item| item.merge("id" => id, "collection" => collection) }
  end


  def identifiers(document)
    document['id'].split(':')
  end

  def facet_links(field, values)
    raw (values.map do |text|
      "#{facet_link(text, field)} (#{field_count(field, text)})"
    end.sort.join(" &nbsp;&bull;&nbsp; "))
  end

  def field_count(field, text)
    "#{record_count(q: "#{field}:\"#{text}\"")}"
  end

  def facet_link(text, field)
    link_to text, URI.escape("/catalog/?f[#{field}][]=#{text}")
  end

  def search_text
    current_search_session.query_params.fetch('q', '')
  end
end