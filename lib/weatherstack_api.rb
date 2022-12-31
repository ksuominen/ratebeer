require 'net/http'
require 'json'

class WeatherstackApi
  def self.get_weather_in(city)
    params = {
      access_key: key,
      query: city
    }
    uri = URI('http://api.weatherstack.com/current')
    uri.query = URI.encode_www_form(params)
    json = Net::HTTP.get(uri)
    JSON.parse(json)
  end

  def self.key
    return nil if Rails.env.test?
    raise 'WEATHERSTACK_APIKEY env variable not defined' if ENV['WEATHERSTACK_APIKEY'].nil?

    ENV.fetch('WEATHERSTACK_APIKEY')
  end
end
