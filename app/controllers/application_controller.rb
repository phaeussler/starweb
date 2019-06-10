class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :execute_request
  BASE_URL = 'https://swapi-graphql-integracion-t3.herokuapp.com'
  
  include HTTParty

  # def execute(query:, variables: nil)
  #   HTTParty.post(
  #     @url,
  #     headers: { 
  #     },
  #     body: { 
  #       query: query,
  #     }.to_json
  #   ).with_indifferent_access
  # end


  # def execute_request(uri)
  #   begin  # "try" block
  #     # uri : str orders or inventories ....
  #     response = HTTParty.get("#{BASE_URL}/#{uri}")
  #     # return response.code, response.body
  #     puts "Solicitud: #{response.code}"
  #     puts JSON.parse(response.body)
  #     puts "Header #{response.headers}"
  #   return response.code, JSON.parse(response.body)
  #   rescue Errno::ECONNREFUSED, Net::ReadTimeout => e
  #     puts "Error #{e}"
  #     return 500, {}
  #   end
  # end

  def execute_request(query)
    # hash_str = hash(method_str, api_key)
    begin  # "try" block
      resp = HTTParty.post(BASE_URL,
        body: { 
          query: query
        })
        # body: query, timeout: 30)
      puts "Solicitud: #{resp.code}"
      # puts JSON.parse(resp.body)
      # puts "Header #{resp.headers}"
      return resp.code, JSON.parse(resp.body), resp.headers
    rescue Errno::ECONNREFUSED, Net::ReadTimeout => e
      puts "Error del otro grupo #{e}"
      return 500, {}, {}
    end
  end

  
  # def get_all(type)
  #   response = execute_request(type)
  #   response['results']
  # end

  # def get_id(url, type='')
  #   if url.include? BASE_URL
  #     url.slice! BASE_URL+'/'+type
  #     url[1...-1]
  #   else
  #     "Error get id"
  #   end
  # end

  # def get_name(url, name="name")
  #   require 'open-uri'
  #   require 'json'
  #   if url.include? BASE_URL
  #     response = open(url).read
  #     JSON.parse(response)[name]
  #   else
  #     "Error"
  #   end
  # end


  # def get_type(url)
  #   types = ['films', 'people', 'planets', 'starships']
  #   types = types.select{|word| url.include? word}
  #   if types.empty?
  #     "Error"
  #   else
  #     types[0]
  #   end
  # end
end
