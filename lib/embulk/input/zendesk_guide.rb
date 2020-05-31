# frozen_string_literal: true
require 'net/http'
require 'date'
require 'json'

require_relative 'zendesk_guide/articles'

module Embulk
  module Input
    class ZendeskGuide < InputPlugin
      Plugin.register_input('zendesk_guide', self)

      def self.transaction(config, &control)
        # configuration code:
        task = {
          'url' => config.param('url', :string),
          'username' => config.param('username', :string),
          'token' => config.param('token', :string)
        }
        columns = Articles.columns
        resume(task, columns, 1, &control)
      end

      def self.resume(task, columns, count)
        yield(task, columns, count)

        next_config_diff = {}
        next_config_diff
      end

      # TODO
      # def self.guess(config)
      #   sample_records = [
      #     {"example"=>"a", "column"=>1, "value"=>0.1},
      #     {"example"=>"a", "column"=>2, "value"=>0.2},
      #   ]
      #   columns = Guess::SchemaGuess.from_hash_records(sample_records)
      #   return {"columns" => columns}
      # end

      def init
        @articles = Articles.new(task['url'], task['username'], task['token'])
      end

      def run
        @articles.get.each do |article|
          page_builder.add(article)
        end

        page_builder.finish

        task_report = {}
        task_report
      end
    end
  end
end
