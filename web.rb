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
    "#{params['callback']}({'error' : 'Must include both 'text' parameter.'})"
  else
    segmented = segment(params['text'])
    "#{params['callback']}(#{JSON(segmented)})"
  end
end