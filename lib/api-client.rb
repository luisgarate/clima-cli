require 'net/http'
require 'uri'
require 'json'
require 'nokogiri'

class ApiClient
  def get_weather(city_name)
    noko = fetch(location_url_by_name(city_name), hour: true)
    day = noko.xpath("//day/@name").first.value
    temperature(noko, day, city_name)
  end

  def get_avg_temp(city_name, max: false)
    noko = fetch(location_url_by_name(city_name), hour: true)
    max ? max_avg(noko, city_name) : min_avg(noko, city_name)
  end


  private
  def fetch(url, hour: false)
    full_url = url + affiliate_id
    full_url += per_hour if hour
    uri = URI.parse(full_url)
    resp = Net::HTTP.get_response(uri)
    Nokogiri::HTML(resp.body)
  end

  def location_url_by_name(city_name)
    noko = fetch(base_url)
    noko.xpath("//name[contains(text(),'#{city_name}')]/ancestor::node()/url").text
  end

  def base_url
    "http://api.tiempo.com/index.php?api_lang=es&division=102"
  end

  def affiliate_id
    "&affiliate_id=zdo2c683olan"
  end

  def per_hour
    "&v=2.0&h=1"
  end

  def temperature(noko, day, city_name)
    hour = noko.xpath("//day[@name='#{day}']/local_info/@local_time").first.value
    interval = hour.split(':').first + ':00'
    temp_value = noko.xpath("//day[@name='#{day}']/hour[@value='#{interval}']/temp/@value").first.value
    temp_unit = noko.xpath("//day[@name='#{day}']/hour[@value='#{interval}']/temp/@unit").first.value
    puts "The actual temperature in #{city_name} is: #{temp_value} #{temp_unit}, #{day}"
  end

  def max_avg(noko, city_name)
    unit = noko.xpath("//day/tempmax/@unit").first.value
    week_max = noko.xpath("//day/tempmax/@value")
    avg = week_max.map { |tmp| tmp.value.to_i}.sum / week_max.size
    puts "The maximum week average temp in #{city_name} is: #{avg} #{unit}"
  end

  def min_avg(noko, city_name)
    unit = noko.xpath("//day/tempmin/@unit").first.value
    week_min = noko.xpath("//day/tempmin/@value")
    avg = week_min.map { |tmp| tmp.value.to_i}.sum / week_min.size
    puts "The minimum week average temp in #{city_name} is: #{avg} #{unit}"
  end


end