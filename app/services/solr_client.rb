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

  def commit
    client.commit
  end

  def delete_by_query(query)
    client.delete_by_query query
  end

  def delete_index
    client.delete_by_query '*:*'
    commit
  end

  def backup(number_to_keep: 1)
    client.get 'replication', params: {
      command: 'backup',
      location: ENV['SOLR_BACKUP_LOCATION'],
      numberToKeep: number_to_keep
    }
  end

  def restore
    client.get 'replication', params: {
      command: 'restore',
      location: ENV['SOLR_BACKUP_LOCATION']
    }
  end
end
