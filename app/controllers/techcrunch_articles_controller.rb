class TechcrunchArticlesController < ApplicationController
  before_filter :set_headers

  def data
    data = cache 'tcbi-total', :expires_in => 15.minutes do
      TechcrunchArticle.running_total
    end

    render :json => data
  end

  def redirect
    redirect_to redirect_url, :status => :found
  end

  private

  def redirect_url
    ENV['redirect_url'] || 'http://toddwschneider.com/'
  end

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end
end
