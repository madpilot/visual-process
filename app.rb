#!/usr/bin/env ruby -w
require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'json'

#                user     pid       cpu          mem     vsz     rss     tt      stat   started time    command
#                root     1         0.0          0.0     2456    732     ??      Ss     Thu08am 5:55.04 /sbin/launchd
#                myles    44240     0.1          1.3   519772  28000     ??      S      10:56pm 0:28.97 /Applications/Google Chrome.app/Contents/Versions/7.0.517.44/Google Chrome Helper.app/Contents/MacOS/Google Chrome Helper --type=plugin --plugin-path=/Applications/Google Chrome.app/Contents/Versions/7.0.517.44/Google Chrome Framework.framework/Internet Plug-Ins/Flash Player Plugin for Chrome.plugin --lang=en-US --plugin-data-dir=/Users/myles/Library/Application Support/Google/Chrome/Default --channel=43855.0x1808d38c.83321292 --enable-crash-reporter=F6FCBC41D4E2BB67F033CBEE09162EC6
#                root         1     0.0          0.0   1748    512       ?        Ss   Nov23   0:03 init [3]:q

OSX_PS_MATCH = /(\w+)\s+(\d+)\s+(\d*\.?\d)\s+(\d*\.?\d)\s+(\d+)\s+(\d+)\s+(\S+)\s+(\w+)\s+(\S+)\s+(\S+)\s+(.+)/

def parse_process
  ps = `ps aux`
  #ps = `ssh root@192.168.0.1 "ps aux"`
  processes = ps.split("\n").map do |process| 
    if process.match(OSX_PS_MATCH)
      {
        :user => $1,
        :pid => $2,
        :cpu => $3,
        :mem => $4,
        :vsz => $5,
        :rss => $6,
        :tt => $7,
        :stat => $8,
        :started => $9,
        :time => $10,
        :command => $11
      }
    else
      nil
    end
  end.compact
end

get '/' do
  haml :index, :layout => false
end

get '/processes.json' do
  content_type :json
  parse_process.to_json
end
