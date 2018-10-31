require 'rsolr'

class SolrClient
 def more_like_this(query)
    client.get 'select', :params => {q: query, start: 0, rows:  9, fl: 'title_ssi, id, type_ssi, format_ssi, format_tesi, compound_objects_ts, borealis_fragment_ssi', mm: '0%'}.merge(mlt_config)
  end

  def mlt_config
    {
      mlt: true,
      'mlt.fl' => 'title_tei, creator_teim, subject_teim, formal_subject_teim, topic_teim, id',
      'mlt.count' => 20,
      'mlt.mintf' => 1
    }
  end

  def client
    connect
  end

  def connect
    Blacklight.default_index.connection
  end

  def swap_cores
    Net::HTTP.get_response(URI("#{ENV['SOLR_BASE_URL']}/solr/admin/cores?action=SWAP&core=#{ENV['SOLR_CORE_0']}&other=#{ENV['SOLR_CORE_1']}"))
  end

  def delete_index
    client.delete_by_query '*:*'
    client.commit
  end
end