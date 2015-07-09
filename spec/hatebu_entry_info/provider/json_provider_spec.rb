# coding: utf-8
require File.expand_path('spec/spec_helper')
include HatebuEntryInfoProvider

describe JsonProvider do
    context 'uninitialized' do
        describe '#initialize' do
            context 'when call' do
                it 'JSON_API_URL' do
                    provider = JsonProvider.new
                    provider.instance_eval('@api_url').should ==
                        'http://b.hatena.ne.jp/entry/json/?url='
                end
            end
        end
    end

    context 'initialized' do
        before(:each) do
            @provider = JsonProvider.new
        end

        describe '#json' do
            context 'when call' do
                it 'JSON_API_URL' do
                    @provider.json
                    @provider.instance_eval('@api_url').should ==
                        'http://b.hatena.ne.jp/entry/json/?url='
                end
            end
        end

        describe '#jsonlite' do
            context 'when call' do
                it 'JSONLITE_API_URL' do
                    @provider.jsonlite
                    @provider.instance_eval('@api_url').should ==
                        'http://b.hatena.ne.jp/entry/jsonlite/?url='
                end
            end
        end

        describe '#get' do
            context 'when nil url input' do
                it 'raise error' do
                    expect { @provider.get(nil)
                    }.to raise_error(RuntimeError, JsonProvider::INVALID_URL_ERROR)
                end
            end

            context 'when null strint url input' do
                it 'raise error' do
                    expect { @provider.get('')
                    }.to raise_error(RuntimeError, JsonProvider::INVALID_URL_ERROR)
                end
            end

            context 'when invalid protcol input' do
                it 'raise error' do
                    expect { @provider.get('ftp://www.test.url/')
                    }.to raise_error(RuntimeError, JsonProvider::INVALID_URL_ERROR)
                end
            end

            context 'when invalid url input' do
                it 'raise error' do
                    expect { @provider.get('http://www.test.url"""/')
                    }.to raise_error(RuntimeError, JsonProvider::INVALID_URL_ERROR)
                end
            end

            context 'when http url input' do
                it 'call download' do
                    url = 'http://www.test.url/'

                    @provider.should_receive(:download).with('http://b.hatena.ne.jp/entry/json/?url=http%3A%2F%2Fwww.test.url%2F')
                    json = @provider.get(url)
                end
            end

            context 'when https url input' do
                it 'call download' do
                    url = 'https://www.test.url/'

                    @provider.should_receive(:download).with('http://b.hatena.ne.jp/entry/json/?url=https%3A%2F%2Fwww.test.url%2F')
                    json = @provider.get(url)
                end
            end
        end
    end
end
