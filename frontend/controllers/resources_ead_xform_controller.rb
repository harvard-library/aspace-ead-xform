class ResourcesEadXformController < ApplicationController
  require 'nokogiri'

  def csv
    Rails.logger.info('*** requested CSV *** ')
  end

end
