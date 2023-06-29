# frozen_string_literal: true
class PagesController < ApplicationController
  def index
    @pages = Page.all
    # Fetching content from teladoc_cms gem's JSON files
    @content = I18n.t('call_details.call_history')
  end
end
