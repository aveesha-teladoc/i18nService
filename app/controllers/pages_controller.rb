# frozen_string_literal: true
class PagesController < ApplicationController
  QUERY_FILE = 'config/graphql_queries/wellness_article.graphql'
  EXECUTE_ENDPOINT_IN_AEM = 'https://author-teladoc-qa.adobecqms.net/graphql/execute.json'

  def index
    @pages = Page.all

  end

  def query_name
    'get-article-by-id'
  end

  # set query path name
  def query_path_in_aem
    "teladoc-wellness/#{query_name}"
  end

  # set query fields from graphql query file
  def query_items
    @query_items ||= File.read(QUERY_FILE).strip
  end

  # graphql query - fetch article by ID
  def query
    <<~GQL
      query articleById($id: String!) {
        articlesList(filter: {id: {_expressions: [{value: $id}]}})  {
          items {#{query_items}}
          }
        }
    GQL
  end

  def get_article(query_path_in_aem, query_items, query, params)
    endpoint = "#{EXECUTE_ENDPOINT_IN_AEM}/#{query_path_in_aem}.json;id=testing-12345"

    # response =
  end
end
