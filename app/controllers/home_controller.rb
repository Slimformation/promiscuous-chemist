class HomeController < ApplicationController
  def index
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
end
