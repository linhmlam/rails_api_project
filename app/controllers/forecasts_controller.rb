class ForecastsController < ApplicationController
  def location
    require 'open-uri'
    require 'json'

    @the_address = params["address"]
    url_safe_address = URI.encode(@the_address)

    # Accessing longitude and latitude
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_address}"
    raw_data = open(url).read
    raw_data.class
    raw_data.length

    parsed_data = JSON.parse(raw_data)
    parsed_data.class
    parsed_data.keys

    the_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    the_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url = "https://api.forecast.io/forecast/5ba14b15020f54a46d53a51646259dfe/#{the_latitude},#{the_longitude}"
    raw_data = open(url).read
    raw_data.class
    raw_data.length

    parsed_data = JSON.parse(raw_data)
    parsed_data.class
    parsed_data.keys

    @the_temperature = parsed_data["currently"]["temperature"]
    @the_hour_outlook = parsed_data["minutely"]["summary"]
    @the_day_outlook = parsed_data["hourly"]["summary"]

    render 'location'
    # puts "The current temperature at #{@the_address} is #{@the_temperature} degrees."
    # puts "The outlook for the next hour is: #{@the_hour_outlook}"
    # puts "The outlook for the next day is: #{@the_day_outlook}"

  end

end
