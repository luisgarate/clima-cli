require 'thor'
require './lib/api-client.rb'

class ClimaCLI < Thor

  desc "eltiempo", "Display the weather"
  method_option :today, type: :boolean, aliases: '-t', desc: 'Diaplay todays weather'
  method_option :av_max, type: :boolean, desc: 'Diaplay the average maximum temperature during the week'
  method_option :av_min, type: :boolean, desc: 'Diaplay the average minimum temperature during the week'

  def eltiempo(city)
    api = ApiClient.new
    api.get_weather(city) if options[:today]
    api.get_avg_temp(city, max: true) if options[:av_max]
    api.get_avg_temp(city) if options[:av_min]
  end

end

ClimaCLI.start(ARGV)