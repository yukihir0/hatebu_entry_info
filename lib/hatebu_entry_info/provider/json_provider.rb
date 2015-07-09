# coding: utf-8
require 'open-uri'
require 'cgi'

module HatebuEntryInfoProvider
  class JsonProvider

    # api url
    JSON_API_URL     = 'http://b.hatena.ne.jp/entry/json/?url='
    JSONLITE_API_URL = 'http://b.hatena.ne.jp/entry/jsonlite/?url='

    # error message
    INVALID_URL_ERROR = 'invalid url is inputted.'

    public
    def initialize
      @api_url = JSON_API_URL
    end

    def json
      @api_url = JSON_API_URL
      self
    end

    def jsonlite
      @api_url = JSONLITE_API_URL
      self
    end

    def get(url)
      raise INVALID_URL_ERROR if invalid_http?(url)

      download(@api_url + CGI.escape(url))
    end

    private
    def invalid_http?(url)
      begin
        uri = URI.parse(url)
      rescue URI::InvalidURIError
        return true
      end
      uri.scheme != 'http' && uri.scheme != 'https'
    end

    def download(url)
      open(url).read
    end
  end
end
