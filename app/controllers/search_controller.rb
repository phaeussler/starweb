class SearchController < ApplicationController
	def index
		@search_text = "#{params[:search]}"
		@films 		= get_all('films').select{|film| film["title"].include? @search_text}
		@people 	= get_all('people').select{|person| person["name"].include? @search_text}
		@planets 	= get_all('planets').select{|planet| planet["name"].include? @search_text}
		@starships 	= get_all('starships').select{|starship| starship["name"].include? @search_text}
	end
end
