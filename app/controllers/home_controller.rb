class HomeController < ApplicationController

  def home
  	if logged_in?
  		@lol = logged_in?
  		puts logged_in?
  	else
  		@lol = logged_in?
  		puts logged_in?.to_s
  	end
  end

  def about
  end

  def privacy
  end

  def contact
  end

end