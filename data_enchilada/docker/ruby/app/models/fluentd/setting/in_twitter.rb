class Fluentd
  module Setting
    class InTwitter
      include ActiveModel::Model
      include Common

      KEYS = [
          :consumer_key,
          :consumer_secret,
          :oauth_token,
          :oauth_token_secret,
          :tag,
          :timeline,
          :keyword,
          :follow_ids,
          :locations,
          :lang,
          :output_format
      ].freeze

      attr_accessor(*KEYS)

      validates :consumer_key, presence: true
      validates :consumer_secret, presence: true
      validates :oauth_token, presence: true
      validates :oauth_token_secret, presence: true
      validates :tag, presence: true
      validates :timeline, presence: true

      def self.initial_params
        {
            tag: 'input.twitter.sampling',
            timeline: 'tracking',
            keyword: '#iphone',
            follow_ids: '',
            locations: '',
            lang: :en,
            output_format: 'simple',
            consumer_key: 'a530R2VCibX8qDE1e19EIvm18',
            consumer_secret: '9QmK9w3ZaAEJGJxmrYd0dE5EhxFdTHTsr57WXHetE21M0VzPv8',
            oauth_token: '454451418-hGagC8lLAwVPfXOLtfNlrPgUnMGuMD7JYvNdyluH',
            oauth_token_secret: 'fqReoxNwIZwCi5v9nd0lOszWssDCHMnO0mpdpTUphh4DH'
        }
      end

      def fields_descriptions
        {
            consumer_key: '* YOUR_CONSUMER_KEY (required)',
            consumer_secret: '* YOUR_CONSUMER_SECRET (required)',
            oauth_token: '* YOUR_CONSUMER_SECRET (required)',
            oauth_token_secret: '* YOUR_CONSUMER_SECRET (required)',
            tag: '* for example input.twitter.sampling (required)',
            timeline: '* tracking or sampling or location or userstream (required)',
            keyword: 'keyword has priority than follow_ids (optional)',
            follow_ids: '"14252,53235" - integers, not screen names (optional)',
            locations: '"31.110283, 129.431631, 45.619283, 145.510175" - bounding boxes; first pair specifies longitude/latitude of southwest corner (optional)',
            lang: 'ja,en (optional)',
            output_format: 'nest or flat or simple[default] (optional)'
        }
      end

      def common_options
        [
          :consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret, :tag, :timeline, :keyword
        ]
      end

      def advanced_options
        [
          :follow_ids, :locations, :lang, :output_format
        ]
      end

      def plugin_name
        "twitter"
      end
    end
  end
end
