class HomeController < ApplicationController
  def index
  end

  # Proxy to Alchemy API
  # http://www.alchemyapi.com/api/categ/urls.html
  #
  # /categorize.json?url=example.com -> JSON response from Alchemy
  def categorize
    out = {}.to_json
    if params[:url]
      # uri_enc_url = Rack::Utils.escape(params[:url])
      endpoint = "http://access.alchemyapi.com/calls/url/URLGetCategory"
      q = "#{endpoint}?apikey=#{ENV["ALCHEMY_KEY"]}&url=#{params[:url]}&outputMode=json"
      out = RestClient.get(q)
    end
    respond_to do |format|
      format.html
      format.json { render :json => out.body }
    end
  end

  # Proxy to Readability Parser API
  # http://www.readability.com/developers/api/parser
  #
  # /simplify.json?url=example.com -> JSON response from Readability
  def simplify
    out = {}.to_json
    if params[:url]
      # is it a url?
      return unless params[:url] =~ /^#{URI::regexp}$/
      # query stuff
      endpoint = "http://www.readability.com/api/content/v1/parser"
      q = "#{endpoint}?url=#{params[:url]}&token=#{ENV["RD_PARSER_KEY"]}"
      out = RestClient.get(q)
    end
    # RSVP
    respond_to do |format|
      format.html
      format.json { render :json => out.body }
    end
  end
end
