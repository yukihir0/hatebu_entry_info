# coding: utf-8
require 'hatebu_entry_info'

def print_entry_info
    header = '----- hatena_bookmark_entry_info -----'
    footer = '-' * header.length

    puts header
    print_body
    print_bookmarks
    print_related
    puts footer
end

def print_body
    puts "・タイトル\t\t#{@entry_info.title}"
    puts "・ブックマーク数\t#{@entry_info.count}"
    puts "・ブックマークURL\t#{@entry_info.url}"
    puts "・エントリーURL\t\t#{@entry_info.entry_url}"
    puts "・スクリーンショット\t#{@entry_info.screenshot}"
    puts "・エントリーID\t\t#{@entry_info.eid}", ''
end

def print_bookmarks
    header = '----- bookmarks -----'
    footer = '-' * header.length
    bookmark_count = 0

    puts header 
    @entry_info.bookmarks.each do |bookmark|
        puts "[#{bookmark_count+=1}]"
        puts "・ユーザ\t\t#{bookmark.user}"
        tag_str =  "・タグ\t\t\t"
        bookmark.tags.each do |tag|
            tag_str += "#{tag} "
        end
        puts "#{tag_str}"
        puts "・ブックマーク時刻\t#{bookmark.timestamp}"
        puts "・コメント\t\t#{bookmark.comment}", ''
    end
    puts footer, ''
end

def print_related
    header = '----- related -----'
    footer = '-' * header.length
    related_count = 0

    puts header
    @entry_info.related.each do |related|
        puts "[#{related_count+=1}]"
        puts "・タイトル\t\t#{related.title}"
        puts "・ブックマーク数\t#{related.count}"
        puts "・ブックマークURL\t#{related.url}"
        puts "・エントリーURL\t\t#{related.entry_url}"
        puts "・エントリーID\t\t#{related.eid}", ''
    end
    puts footer
end


url = 'http://www.hatena.ne.jp/'
api = HatebuEntryInfo.new

# when json api call
@entry_info = api.get_json(url)

# when jsonlite api call
# @entry_info = api.get_jsonlite(url)

print_entry_info
