# coding: utf-8

module HatebuEntryInfoEntity
  class EntryInfo
    attr_accessor :query_url
    attr_accessor :title
    attr_accessor :count
    attr_accessor :url
    attr_accessor :entry_url
    attr_accessor :screenshot
    attr_accessor :eid
    attr_accessor :bookmarks
    attr_accessor :related

    public
    def initialize
      @bookmarks = Array.new
      @related   = Array.new
    end
  end
end
