
class NokogiriTestSchool
  require 'nokogiri'
  require 'open-uri'

  require 'weatherforecast.rb'

  proxy_uri = 'http://proxy.oita-ct.ac.jp:80'
  prx_opt = {:proxy => proxy_uri}

  url = 'http://www.data.jma.go.jp/developer/xml/feed/regular_l.xml'
  xml = Nokogiri::XML(open(url,prx_opt).read)
  xml.remove_namespaces!
  entry_nodes = xml.xpath('//entry')

  entry_nodes.each do |entry|
    if '府県天気予報' === entry.xpath('title').text then
      if /.*大分.*/ === entry.xpath('content').text then
        puts "タイトル:" + entry.xpath('title').text
        puts "link:" + entry.xpath('link/@href').text
        puts "観測地点:" + entry.xpath('author/name').text
        puts "コンテンツ:" + entry.xpath('content').text
        forecast_xml_url = entry.xpath('link/@href').text
        forecast_xml = Nokogiri::XML(open(forecast_xml_url,prx_opt).read)
        forecast_xml.remove_namespaces!

        item_nodes = forecast_xml.xpath('//Item')
        item_nodes.each do |item|
          if '中部' === item.xpath('Area/Name').text then
            weatherForecastPart = item.xpath('//WeatherForecastPart[@refID="1"]')[0]
            puts forecast_xml.xpath('//TimeDefine[@timeId="1"]')[0].xpath('DateTime').text + ":今日の中部の天気予報:" + weatherForecastPart.xpath('Sentence').text



            weatherForecast = Weatherforecast.new
            weatherForecast.area_code_forecast = 0
            weatherForecast.time_id_1 = forecast_xml.xpath('//TimeDefine[@timeId="1"]')[0].xpath('DateTime').text
            weatherForecast.time_id_2 = forecast_xml.xpath('//TimeDefine[@timeId="2"]')[0].xpath('DateTime').text
            weatherForecast.time_id_3 = forecast_xml.xpath('//TimeDefine[@timeId="3"]')[0].xpath('DateTime').text

            weatherForecast.weather_1 = weatherForecastPart.xpath('Sentence').text
            weatherForecast.weather_2 = item.xpath('//WeatherForecastPart[@refID="2"]')[0].xpath('Sentence').text
            weatherForecast.weather_3 = item.xpath('//WeatherForecastPart[@refID="3"]')[0].xpath('Sentence').text

            weatherForecast.save

            break
          end
        end
        break
      end
    end

  end


end