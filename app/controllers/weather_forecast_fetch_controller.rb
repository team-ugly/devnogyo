class WeatherForecastFetchController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def index
    proxy_uri = 'http://proxy.oita-ct.ac.jp:80'
    prx_opt = {:proxy => proxy_uri}

    url = 'http://www.data.jma.go.jp/developer/xml/feed/regular_l.xml'
    xml = Nokogiri::XML(open(url, prx_opt).read)
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
          forecast_xml = Nokogiri::XML(open(forecast_xml_url, prx_opt).read)
          forecast_xml.remove_namespaces!

          time_series_info_nodes = forecast_xml.xpath('//TimeSeriesInfo')
          weatherForecastArr = [WeatherForecast.new, WeatherForecast.new, WeatherForecast.new, WeatherForecast.new,]

          weatherForecastArr[0].area_code_forecast = 0
          weatherForecastArr[1].area_code_forecast = 1
          weatherForecastArr[2].area_code_forecast = 2
          weatherForecastArr[3].area_code_forecast = 3
          #time_defines = forecast_xml.xpath('//TimeDefines')
          item_nodes_arr = time_series_info_nodes.map {|time_series_info| time_series_info.xpath('.//Item')}

          item_nodes_arr[0].zip(weatherForecastArr).each do |item, weatherForecast|
            #if '中部' === item.xpath('.//Area/Name').text then
              #weatherForecastPart = item.xpath('.//WeatherForecastPart[@refID="1"]')[0]

              #weatherForecastテーブルにデータをinsert
              #weatherForecast = WeatherForecast.new

              #weatherForecast.area_code_forecast = 0
              weatherForecast.time_id_1 = time_series_info_nodes[0].xpath('.//TimeDefine[@timeId="1"]')[0].xpath('DateTime').text
              weatherForecast.time_id_2 = time_series_info_nodes[0].xpath('.//TimeDefine[@timeId="2"]')[0].xpath('DateTime').text
              weatherForecast.time_id_3 = time_series_info_nodes[0].xpath('.//TimeDefine[@timeId="3"]')[0].xpath('DateTime').text

              weatherForecast.weather_1 = item.xpath('.//WeatherForecastPart[@refID="1"]')[0].xpath('Sentence').text
              weatherForecast.weather_2 = item.xpath('.//WeatherForecastPart[@refID="2"]')[0].xpath('Sentence').text
              weatherForecast.weather_3 = item.xpath('.//WeatherForecastPart[@refID="3"]')[0].xpath('Sentence').text

              weatherForecast.wind_1 = item.xpath('.//WindForecastPart[@refID="1"]')[0].xpath('Sentence').text
              weatherForecast.wind_2 = item.xpath('.//WindForecastPart[@refID="2"]')[0].xpath('Sentence').text
              weatherForecast.wind_3 = item.xpath('.//WindForecastPart[@refID="3"]')[0].xpath('Sentence').text


              #break
            #end
          end

          item_nodes_arr[1].zip(weatherForecastArr).each do |item, weatherForecast|

            weatherForecast.rain_time_id_1 = time_series_info_nodes[1].xpath('.//TimeDefine[@timeId="1"]')[0].xpath('DateTime').text
            weatherForecast.rain_time_id_2 = time_series_info_nodes[1].xpath('.//TimeDefine[@timeId="2"]')[0].xpath('DateTime').text
            weatherForecast.rain_time_id_3 = time_series_info_nodes[1].xpath('.//TimeDefine[@timeId="3"]')[0].xpath('DateTime').text
            weatherForecast.rain_time_id_4 = time_series_info_nodes[1].xpath('.//TimeDefine[@timeId="4"]')[0].xpath('DateTime').text
            weatherForecast.rain_time_id_5 = time_series_info_nodes[1].xpath('.//TimeDefine[@timeId="5"]')[0].xpath('DateTime').text
            weatherForecast.rain_time_id_6 = time_series_info_nodes[1].xpath('.//TimeDefine[@timeId="6"]')[0].xpath('DateTime').text

            weatherForecast.rain_1 = item.xpath('.//ProbabilityOfPrecipitationPart[@refID="1"]/@description')[0].text
            weatherForecast.rain_2 = item.xpath('.//ProbabilityOfPrecipitationPart[@refID="2"]/@description')[0].text
            weatherForecast.rain_3 = item.xpath('.//ProbabilityOfPrecipitationPart[@refID="3"]/@description')[0].text
            weatherForecast.rain_4 = item.xpath('.//ProbabilityOfPrecipitationPart[@refID="4"]/@description')[0].text
            weatherForecast.rain_5 = item.xpath('.//ProbabilityOfPrecipitationPart[@refID="5"]/@description')[0].text
            weatherForecast.rain_6 = item.xpath('.//ProbabilityOfPrecipitationPart[@refID="6"]/@description')[0].text

          end

          item_nodes_arr[2].zip(weatherForecastArr).each do |item, weatherForecast|

            weatherForecast.max_min_temperature_time_id_1 = time_series_info_nodes[2].xpath('.//TimeDefine[@timeId="1"]')[0].xpath('DateTime').text
            weatherForecast.max_min_temperature_time_id_2 = time_series_info_nodes[2].xpath('.//TimeDefine[@timeId="2"]')[0].xpath('DateTime').text
            weatherForecast.max_min_temperature_time_id_3 = time_series_info_nodes[2].xpath('.//TimeDefine[@timeId="3"]')[0].xpath('DateTime').text
            weatherForecast.max_min_temperature_time_id_4 = time_series_info_nodes[2].xpath('.//TimeDefine[@timeId="4"]')[0].xpath('DateTime').text

            #temperaturepartが３つしかない場合などがあるため対策が必要になると思われる
            weatherForecast.max_min_temperature_1 = item.xpath('.//TemperaturePart[@refID="1"]/@description')[0].text
            weatherForecast.max_min_temperature_2 = item.xpath('.//TemperaturePart[@refID="2"]/@description')[0].text
            weatherForecast.max_min_temperature_3 = item.xpath('.//TemperaturePart[@refID="3"]/@description')[0].text
            weatherForecast.max_min_temperature_4 = item.xpath('.//TemperaturePart[@refID="4"]/@description')[0].text
          end

          item_nodes_arr[3].zip(weatherForecastArr).each do |item, weatherForecast|

            weatherForecast.weather_detail_time_id_1 = time_series_info_nodes[3].xpath('.//TimeDefine[@timeId="1"]')[0].xpath('DateTime').text
            weatherForecast.weather_detail_time_id_2 = time_series_info_nodes[3].xpath('.//TimeDefine[@timeId="2"]')[0].xpath('DateTime').text
            weatherForecast.weather_detail_time_id_3 = time_series_info_nodes[3].xpath('.//TimeDefine[@timeId="3"]')[0].xpath('DateTime').text
            weatherForecast.weather_detail_time_id_4 = time_series_info_nodes[3].xpath('.//TimeDefine[@timeId="4"]')[0].xpath('DateTime').text
            weatherForecast.weather_detail_time_id_5 = time_series_info_nodes[3].xpath('.//TimeDefine[@timeId="5"]')[0].xpath('DateTime').text
            weatherForecast.weather_detail_time_id_6 = time_series_info_nodes[3].xpath('.//TimeDefine[@timeId="6"]')[0].xpath('DateTime').text
            weatherForecast.weather_detail_time_id_7 = time_series_info_nodes[3].xpath('.//TimeDefine[@timeId="7"]')[0].xpath('DateTime').text
            weatherForecast.weather_detail_time_id_8 = time_series_info_nodes[3].xpath('.//TimeDefine[@timeId="8"]')[0].xpath('DateTime').text
            weatherForecast.weather_detail_time_id_9 = time_series_info_nodes[3].xpath('.//TimeDefine[@timeId="9"]')[0].xpath('DateTime').text
            weatherForecast.weather_detail_time_id_10 = time_series_info_nodes[3].xpath('.//TimeDefine[@timeId="10"]')[0].xpath('DateTime').text

            #8つしかない場合などがあるため対策が必要になると思われる
            weatherForecast.weather_detail_1 = item.xpath('.//jmx_eb:Weather[@refID="1"]')[0].text
            weatherForecast.weather_detail_2 = item.xpath('.//jmx_eb:Weather[@refID="2"]')[0].text
            weatherForecast.weather_detail_3 = item.xpath('.//jmx_eb:Weather[@refID="3"]')[0].text
            weatherForecast.weather_detail_4 = item.xpath('.//jmx_eb:Weather[@refID="4"]')[0].text
            weatherForecast.weather_detail_5 = item.xpath('.//jmx_eb:Weather[@refID="5"]')[0].text
            weatherForecast.weather_detail_6 = item.xpath('.//jmx_eb:Weather[@refID="6"]')[0].text
            weatherForecast.weather_detail_7 = item.xpath('.//jmx_eb:Weather[@refID="7"]')[0].text
            weatherForecast.weather_detail_8 = item.xpath('.//jmx_eb:Weather[@refID="8"]')[0].text
            weatherForecast.weather_detail_9 = item.xpath('.//jmx_eb:Weather[@refID="9"]')[0].text
            weatherForecast.weather_detail_10 = item.xpath('.//jmx_eb:Weather[@refID="10"]')[0].text

          end

          item_nodes_arr[4].zip(weatherForecastArr).each do |item, weatherForecast|

            weatherForecast.temperature_time_id_1 = time_series_info_nodes[4].xpath('.//TimeDefine[@timeId="1"]')[0].xpath('DateTime').text
            weatherForecast.temperature_time_id_2 = time_series_info_nodes[4].xpath('.//TimeDefine[@timeId="2"]')[0].xpath('DateTime').text
            weatherForecast.temperature_time_id_3 = time_series_info_nodes[4].xpath('.//TimeDefine[@timeId="3"]')[0].xpath('DateTime').text
            weatherForecast.temperature_time_id_4 = time_series_info_nodes[4].xpath('.//TimeDefine[@timeId="4"]')[0].xpath('DateTime').text
            weatherForecast.temperature_time_id_5 = time_series_info_nodes[4].xpath('.//TimeDefine[@timeId="5"]')[0].xpath('DateTime').text
            weatherForecast.temperature_time_id_6 = time_series_info_nodes[4].xpath('.//TimeDefine[@timeId="6"]')[0].xpath('DateTime').text
            weatherForecast.temperature_time_id_7 = time_series_info_nodes[4].xpath('.//TimeDefine[@timeId="7"]')[0].xpath('DateTime').text
            weatherForecast.temperature_time_id_8 = time_series_info_nodes[4].xpath('.//TimeDefine[@timeId="8"]')[0].xpath('DateTime').text
            weatherForecast.temperature_time_id_9 = time_series_info_nodes[4].xpath('.//TimeDefine[@timeId="9"]')[0].xpath('DateTime').text

            #temperaturepartが３つしかない場合などがあるため対策が必要になると思われる
            weatherForecast.temperature_1 = item.xpath('.//jmx_eb:Temperature[@refID="1"]/@description')[0].text
            weatherForecast.temperature_2 = item.xpath('.//jmx_eb:Temperature[@refID="2"]/@description')[0].text
            weatherForecast.temperature_3 = item.xpath('.//jmx_eb:Temperature[@refID="3"]/@description')[0].text
            weatherForecast.temperature_4 = item.xpath('.//jmx_eb:Temperature[@refID="4"]/@description')[0].text
            weatherForecast.temperature_5 = item.xpath('.//jmx_eb:Temperature[@refID="5"]/@description')[0].text
            weatherForecast.temperature_6 = item.xpath('.//jmx_eb:Temperature[@refID="6"]/@description')[0].text
            weatherForecast.temperature_7 = item.xpath('.//jmx_eb:Temperature[@refID="7"]/@description')[0].text
            weatherForecast.temperature_8 = item.xpath('.//jmx_eb:Temperature[@refID="8"]/@description')[0].text
            weatherForecast.temperature_9 = item.xpath('.//jmx_eb:Temperature[@refID="9"]/@description')[0].text

          end


          #weatherForecastArr[0].save
          weatherForecastArr.each do |weatherForecast|
            weatherForecast.save
          end

          #一番新しい天気予報だけ取得したら抜ける
          break
        end
      end

    end
  end

end