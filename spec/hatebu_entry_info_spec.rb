# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe HatebuEntryInfo do
  context 'uninitialized' do
    describe '#initialize' do
      context 'when call' do
        it 'JsonProvider' do
          api = HatebuEntryInfo.new
          provider = api.instance_eval('@provider')
          provider.instance_of?(JsonProvider).should be_truthy
        end
      end
    end
  end

  context 'initialized' do
    before(:each) do
      @api      = HatebuEntryInfo.new
      @raw_data = File.open(File.dirname(__FILE__) + '/data/test.json', 'r').read
    end

    describe '#get_json' do
      context 'when url input' do
        it 'call provider #json, #get' do
          url = 'http://www.test.url/'

          provider = double('provider')
          provider.should_receive(:json).and_return(provider)
          provider.should_receive(:get).with(url).and_return(@raw_data)
          @api.instance_variable_set(:@provider, provider)

          entry_info = @api.get_json(url)
        end
      end
    end

    describe '#get_json_lite' do
      context 'when url input' do
        it 'call provider #jsonlite, #get' do
          url = 'http://www.test.url/'

          provider = double('provider')
          provider.should_receive(:jsonlite).and_return(provider)
          provider.should_receive(:get).with(url).and_return(@raw_data)
          @api.instance_variable_set(:@provider, provider)

          entry_info = @api.get_jsonlite(url)
        end
      end
    end

    describe '#parse' do
      context 'when json raw_data input' do
        it 'parse to entry_info' do
          entry_info = @api.send(:parse, @raw_data)

          entry_info.title.should            == 'test_title'
          entry_info.count.should            == '12345'
          entry_info.url.should              == 'http://www.test.url/'
          entry_info.entry_url.should        == 'http://b.hatena.ne.jp/entry/www.test.url/'
          entry_info.screenshot.should       == 'http://screenshot.hatena.ne.jp/images/200x150/test.jpg'
          entry_info.eid.should              == '54321'
          entry_info.bookmarks.length.should == 2
          bookmark1 = entry_info.bookmarks[0]
          bookmark1.user.should == 'test_user1'
          bookmark1.tags.should == ['tag1', 'tag2']
          bookmark1.timestamp.should == '2013/02/01 12:34:56'
          bookmark1.comment.should   == 'test_comment1'

          bookmark2 = entry_info.bookmarks[1]
          bookmark2.user.should == 'test_user2'
          bookmark2.tags.should == ['tag2', 'tag3']
          bookmark2.timestamp.should == '2013/02/02 12:56:34'
          bookmark2.comment.should   == 'test_comment2'

          entry_info.related.length.should   == 2
          related1 = entry_info.related[0]
          related1.title.should              == 'related1_title'
          related1.count.should              == '1'
          related1.url.should                == 'http://www.related1.url/'
          related1.entry_url.should          == 'http://b.hatena.ne.jp/entry/www.related1.url/'
          related1.eid.should                == '00001'

          related2 = entry_info.related[1]
          related2.title.should              == 'related2_title'
          related2.count.should              == '2'
          related2.url.should                == 'http://www.related2.url/'
          related2.entry_url.should          == 'http://b.hatena.ne.jp/entry/www.related2.url/'
          related2.eid.should                == '00002'
        end
      end
    end
  end
end
