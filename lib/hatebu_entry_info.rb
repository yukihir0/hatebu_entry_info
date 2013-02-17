# coding: utf-8
require 'hatebu_entry_info/version'
require 'json'
require 'provider/json_provider'
require 'entity/entry_info'
require 'entity/bookmark'
require 'entity/related'

class HatebuEntryInfo
    include HatebuEntryInfoProvider
    include HatebuEntryInfoEntity

    # error message
    INVALID_SYNTAX_ERROR = 'json syntax is invalid.'

    public
    def initialize
        @provider = JsonProvider.new
    end

    def get_json(url)
        raw_data = @provider.json.get(url)
        parse(raw_data)
    end

    def get_jsonlite(url)
        raw_data = @provider.jsonlite.get(url)
        parse(raw_data)
    end

    private
    def parse(raw_data)
        entry_info = EntryInfo.new
        
        json = JSON.parse(raw_data)
        json.each { |key, value|
            case key
            when 'title'
                entry_info.title = value
            when'count'
                entry_info.count = value
            when 'url'
                entry_info.url = value
            when 'entry_url'
                entry_info.entry_url = value
            when 'screenshot'
                entry_info.screenshot = value
            when 'eid'
                entry_info.eid = value
            when 'bookmarks'
                value.each { |b|
                    entry_info.bookmarks << parse_bookmark(b)
                }
            when 'related'
                value.each { |r|
                    entry_info.related << parse_related(r)
                }
            else
                raise INVALID_SYNTAX_ERROR
            end
        }
        entry_info
    end

    def parse_bookmark(b)
        bookmark           = Bookmark.new
        bookmark.user      = b['user']
        bookmark.tags      = b['tags']
        bookmark.timestamp = b['timestamp']
        bookmark.comment   = b['comment']
        bookmark
    end

    def parse_related(r)
        related           = Related.new
        related.title     = r['title']
        related.count     = r['count']
        related.url       = r['url']
        related.entry_url = r['entry_url']
        related.eid       = r['eid']
        related
    end
end
