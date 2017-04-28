require 'open-uri'

class VisitorsController < ApplicationController
  def index
    #@page = Nokogiri::HTML(open("http://www.alexa.com/topsites"))
    redirect_to sites_url
  end
end
