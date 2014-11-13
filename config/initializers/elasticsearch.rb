require 'elasticsearch/rails/instrumentation'
# require 'elasticsearch/rails/lograge'

Tire.configure do
  url ENV['ELASTICSEARCH_URL']
end

Elasticsearch::Model.client = Elasticsearch::Client.new url: ENV['ELASTICSEARCH_URL'], log: true

#if ENV['ELASTICSEARCH_URL']
  #Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV['ELASTICSEARCH_URL'], log: false
#end

#Kaminari::Hooks.init
#Elasticsearch::Model::Response::Response.__send__ :include, Elasticsearch::Model::Response::Pagination::Kaminari

NGRAM_ANALYZER = {
  analysis: {
    filter: {
      ngram_filter: {
        type: 'nGram',
        min_gram: 4,
        max_gram: 15
      }
    },
    analyzer: {
      ngram_analyzer: {
        tokenizer: 'lowercase',
        filter: ['ngram_filter'],
        type: 'custom'
      }
    }
  }
}

