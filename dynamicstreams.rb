#!/usr/bin/env ruby
require 'sinatra'
require 'json'

configure do
    set :port, ARGV[0] if ARGV.any? #port from commandline

    GlobalState = {
        :streams =>{
            :red=>["sakurako","two","three"],
            :green=>["four","five","six"],
            :blue=>["seven","eight","nine"]
        },
        :important=>{
            :red=>"",
            :green=>"",
            :blue=>""
        },
        :server=>"http://localhost:8000/live/"
    }
end

get '/stream' do
    streams = GlobalState[:streams]
    allStreams = streams.values.flatten
    colours={}
    allStreams.each do |name|
        colours[name]="red" if streams[:red].include? name
        colours[name]="green" if streams[:green].include? name
        colours[name]="blue" if streams[:blue].include? name
    end
    erb :streams, :locals => {
        :streams =>allStreams,
        :colours => colours,
        :server=>GlobalState[:server]
    }

end

get '/control' do
    erb :control, :locals=>{
        :streams=>GlobalState[:streams]
    }
end

get '/importance' do
    content_type :json
    response.body = JSON.dump( GlobalState[:important].values)
end

post '/importance' do
    name = JSON.parse(request.body.read)['name']
    streams = GlobalState[:streams]
    GlobalState[:important][:red] = name if streams[:red].include? name
    GlobalState[:important][:green] = name if streams[:green].include? name
    GlobalState[:important][:blue] = name if streams[:blue].include? name
end
