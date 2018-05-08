
require 'net/http'

require_relative '../lib/ead_transformer'

class ResourcesEadXformController < ApplicationController
  set_access_control  "view_repository" => [:staff_csv]

  EAD_PARAMS = {:include_unpublished => false,
                :print_pdf => false,
                :include_daos => true,
                :numbered_cs => false,
                :ead3 =>  false }
  def staff_csv
    request_uri = "/repositories/#{JSONModel::repository}/resource_descriptions/#{params[:id]}.xml"
    Rails.logger.debug("*** request uri: #{request_uri}")
    ead = ""
    xml_response(request_uri, params) do |chunk, percent|
      ead << chunk if !chunk.blank?
    end

#    Rails.logger.debug("*** ead: \n #{ead}")

    xform = EadTransformer.new(ead.force_encoding("UTF-8") , %w{ead2mods.xsl mods2csv.xsl})
    ead = xform.transform
 #   Pry::ColorPrinter.pp ead
    respond_to do |format|
      format.csv {
        headers['Last-Modified'] = Time.now.ctime.to_s
        headers['Content-Disposition'] = "attachment; filename=\"resource_#{params[:id]}.csv\""
        headers['Content-Type'] = 'text/csv'
        self.response_body = ead.to_s
      }
    end
  end

  private
  def xml_response(request_uri, params = EAD_PARAMS)
    JSONModel::HTTP::stream(request_uri, params) do |res|
      size, total = 0, res.header['Content-Length'].to_i
      res.read_body do |chunk|
        size += chunk.size
        percent = total > 0 ? ((size * 100) / total) : 0
        yield chunk, percent
      end
    end
  end

end
