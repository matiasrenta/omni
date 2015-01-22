module OmniAuth
  module Strategies
    class Umanager < OmniAuth::Strategies::OAuth2
      option :name, :umanager

      option :client_options, {
          site: "http://localhost:3001",
          authorize_path: "/oauth/authorize"
      }

      uid do
        raw_info["id"]
      end

      info do
        {name: raw_info["name"]}
      end

      def raw_info
        @raw_info ||= access_token.get('/user').parsed
      end
    end
  end
end

