require 'embulk/column'

class Articles
  def initialize(url, username, token)
    @url = url
    @username = username
    @token = token
  end

  def self.columns
    [
      Embulk::Column.new(0, 'id', :long),
      Embulk::Column.new(1, 'url', :string),
      Embulk::Column.new(2, 'html_url', :string),
      Embulk::Column.new(3, 'title', :string),
      Embulk::Column.new(4, 'body', :string),
      Embulk::Column.new(5, 'locale', :string),
      Embulk::Column.new(6, 'source_locale', :string),
      Embulk::Column.new(7, 'author_id', :long),
      Embulk::Column.new(8, 'comments_disabled', :boolean),
      Embulk::Column.new(9, 'outdated_locales', :string),
      Embulk::Column.new(10, 'outdated', :boolean),
      Embulk::Column.new(11, 'label_names', :string),
      Embulk::Column.new(12, 'draft', :boolean),
      Embulk::Column.new(13, 'promoted', :boolean),
      Embulk::Column.new(14, 'position', :long),
      Embulk::Column.new(15, 'vote_sum', :long),
      Embulk::Column.new(16, 'vote_count', :long),
      Embulk::Column.new(17, 'section_id', :long),
      Embulk::Column.new(18, 'user_segment_id', :long),
      Embulk::Column.new(19, 'permission_group_id', :long),
      Embulk::Column.new(20, 'created_at', :timestamp),
      Embulk::Column.new(21, 'edited_at', :timestamp),
      Embulk::Column.new(22, 'updated_at', :timestamp)
    ]
  end

  def get
    result = []
    next_url = "#{@url}/help_center/ja/articles.json"
    until next_url.nil?
      tmp, next_url = get_from_url(next_url)
      result.concat(tmp)
      return result if next_url.nil?

      sleep 1
      end
  end

  private

  def get_from_url(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = uri.scheme === 'https'

    req = Net::HTTP::Get.new(uri.to_s)
    req.basic_auth(@username, @token)
    response = JSON.parse(http.request(req).body)

    [response['articles'].map do |article|
      [
        article['id'],
        article['url'],
        article['html_url'],
        article['title'],
        article['body'],
        article['locale'],
        article['source_locale'],
        article['author_id'],
        article['comments_disabled'],
        article['outdated_locales'],
        article['outdated'],
        article['label_names'],
        article['draft'],
        article['promoted'],
        article['position'],
        article['vote_sum'],
        article['vote_count'],
        article['section_id'],
        article['user_segment_id'],
        article['permission_group_id'],
        Date.parse(article['created_at']).to_time,
        Date.parse(article['edited_at']).to_time,
        Date.parse(article['updated_at']).to_time
      ]
    end, response['next_page']]
  end
end
