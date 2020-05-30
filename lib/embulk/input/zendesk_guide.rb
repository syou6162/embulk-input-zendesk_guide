require "net/http"
require 'json'

module Embulk
  module Input

    class ZendeskGuide < InputPlugin
      Plugin.register_input("zendesk_guide", self)

      def self.transaction(config, &control)
        # configuration code:
        task = {
          "url" => config.param("url", :string),
          "username" => config.param("username", :string),
          "token" => config.param("token", :string),
        }

        columns = [
          Column.new(0, "id", :long),
          Column.new(1, "url", :string),
          Column.new(2, "html_url", :string),
          Column.new(3, "title", :string),
          Column.new(4, "body", :string),
          Column.new(5, "locale", :string),
          Column.new(6, "source_locale", :string),
          Column.new(7, "author_id", :long),
          Column.new(8, "comments_disabled", :boolean),
          Column.new(9, "outdated_locales", :string),
          Column.new(10, "outdated", :boolean),
          Column.new(11, "label_names", :string),
          Column.new(12, "draft", :boolean),
          Column.new(13, "promoted", :boolean),
          Column.new(14, "position", :long),
          Column.new(15, "vote_sum", :long),
          Column.new(16, "vote_count", :long),
          Column.new(17, "section_id", :long),
          Column.new(18, "user_segment_id", :long),
          Column.new(19, "permission_group_id", :long),
          Column.new(20, "created_at", :timestamp),
          Column.new(21, "edited_at", :timestamp),
          Column.new(22, "updated_at", :timestamp),
        ]

        resume(task, columns, 1, &control)
      end

      def self.resume(task, columns, count, &control)
        task_reports = yield(task, columns, count)

        next_config_diff = {}
        return next_config_diff
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
        # initialization code:
        @option1 = task["option1"]
        @option2 = task["option2"]
        @option3 = task["option3"]
        @url = task["url"]
        @username = task["username"]
        @token = task["token"]

      end

      def run
        uri = URI.parse("#@url/help_center/ja/articles.json")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = uri.scheme === "https"

        req = Net::HTTP::Get.new(uri.path)
        req.basic_auth(@username, @token)
        response = http.request(req)
        JSON.parse(response.body)["articles"].each {|article|
          page_builder.add([
            article["id"],
            article["url"],
            article["html_url"],
            article["title"],
            article["body"],
            article["locale"],
            article["source_locale"],
            article["author_id"],
            article["comments_disabled"],
            article["outdated_locales"],
            article["outdated"],
            article["label_names"],
            article["draft"],
            article["promoted"],
            article["position"],
            article["vote_sum"],
            article["vote_count"],
            article["section_id"],
            article["user_segment_id"],
            article["permission_group_id"],
            article["created_at"],
            article["edited_at"],
            article["updated_at"],
          ])
        }

        page_builder.finish

        task_report = {}
        return task_report
      end
    end

  end
end
