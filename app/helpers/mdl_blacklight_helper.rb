module MdlBlacklightHelper
  include Blacklight::LayoutHelperBehavior

  def current_search
    request.original_url.gsub(/\/$/, '')
  end

  def current_search_json
    current_search.gsub(/\?|catalog\/\?|catalog\?/, 'catalog.json?')
  end

  def json_result_link
    link_to(raw('<div class="icon-json pull-right"><span class="sr-only">Download JSON</span></div>'), current_search_json, {class: 'json-link'})
  end

  def json_page_link
    link_to(raw('<div class="icon-json text-center"><span class="sr-only">Download JSON</span></div>'), "#{uri.scheme}://#{uri.host}:#{uri.port}/#{uri.path}.json", {class: 'json-link'})
  end

  def uri
    URI::parse(request.original_url)
  end

  def record_count(q: '*:*')
    number_with_delimiter(Blacklight.default_index.connection.get('select',
      :params => { :q => q,
        :defType => 'edismax',
        :fl => '',
        :rows => 1
      })['response']['numFound'])
  end

 ##
  # Classes used for sizing the sidebar content of a Blacklight page
  # @return [String]
  def sidebar_classes
    'col-md-12 col-sm-12 col-lg-3'
  end
end
