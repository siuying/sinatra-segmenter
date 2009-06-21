require 'rubygems'
require 'sinatra'
require 'erb'
require 'json'
require 'lib/segmenter'

get "/" do
  erb :index
end

get "/segmenter" do
  if !params['text'] || !params['callback'] 
    "#{params['callback']}({'error' : 'Must include both 'text' and 'callback' parameter.'})"
  else
    begin
      segmented = segment(params['text'])
      result    = JSON(segmented)
      "#{params['callback']}(#{result})"
    rescue StandardError => e
      "#{params['callback']}({'error' : '#{e.message}'})"
    end
  end
end