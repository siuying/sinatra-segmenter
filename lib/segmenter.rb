require 'sinatra/base'

gem 'rmmseg-cpp'
require 'rmmseg'

module Sinatra
  module Segmenter
    module Helpers
      def segment(text='')
        return [] if (text.nil? || text.strip.nil?)
        algor = RMMSeg::Algorithm.new(text)
        result = []
        loop do
          tok = algor.next_token
          break if tok.nil?
          result << tok.text
        end
        result
      end
    end
    
    RMMSeg::Dictionary.load_dictionaries
    def self.registered(app)
      app.helpers Segmenter::Helpers
    end
  end
  
  register Segmenter
end