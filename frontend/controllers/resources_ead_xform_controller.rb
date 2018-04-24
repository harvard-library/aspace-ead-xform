
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
    Rails.logger.info('*** requested CSV *** ')
    # temporary hardcded ead
    temp = <<-END_HERE
    <?xml version="1.0" encoding="utf-8"?>
<ead audience="internal" xmlns="urn:isbn:1-931666-22-9" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="urn:isbn:1-931666-22-9 http://www.loc.gov/ead/ead.xsd"><eadheader countryencoding="iso3166-1" dateencoding="iso8601" langencoding="iso639-2b" repositoryencoding="iso15511"><eadid>testSpreadsheet</eadid><filedesc><titlestmt><titleproper>Test Spreadsheet for demo purposes<num>bf-test</num></titleproper></titlestmt><publicationstmt><publisher>Archivists Toolkit</publisher></publicationstmt></filedesc><profiledesc><creation>This finding aid was produced using ArchivesSpace on <date>2018-04-13 11:35:51 -0400</date>.</creation></profiledesc></eadheader><archdesc level="collection">
  <did>
    <langmaterial>
      <language langcode="eng">English</language>
    </langmaterial>
    <repository>
      <corpname>Archivists Toolkit</corpname>
    </repository>
    <unittitle>Test Spreadsheet for demo purposes</unittitle>
    <unitid>bf-test</unitid>
    <physdesc altrender="whole">
      <extent altrender="materialtype spaceoccupied">1 cubic feet</extent>
    </physdesc>
    <unitdate normal="1900/2017" type="inclusive">1900-2017</unitdate>
  </did>
  <dsc><c audience="internal" id="aspace_testSpreadsheetc00009" level="file"><did><unittitle>Philadelphia Key Contacts</unittitle><unitdate normal="2004/2004">2004 May</unitdate><container id="aspace_7e1749e0a867ff858195a69c8f01b1e7" label="Mixed Materials" type="Box">43</container><container id="aspace_73690d3a4c03fff71d5c0b1c4891fc0c" parent="aspace_7e1749e0a867ff858195a69c8f01b1e7" type="Folder">1</container></did></c><c audience="internal" id="aspace_testSpreadsheetc00010" level="file"><did><unittitle>Philadelphia Campaign for Human Capital - Research Interview Schedule</unittitle><unitdate normal="2004/2004">2004 May</unitdate><container id="aspace_66ab762f89484c6070630f5fb3f6fdbc" label="Mixed Materials" type="Box">43</container><container id="aspace_7cef6fd1eb93f38ab774ea1d8e7d1bd5" parent="aspace_66ab762f89484c6070630f5fb3f6fdbc" type="Folder">2</container></did></c></dsc>
</archdesc>
</ead>
END_HERE

    request_uri = "/repositories/#{JSONModel::repository}/resource_descriptions/#{params[:id]}.xml"
#    request_uri = "resources/#{params[:id]}/download_ead"
   Rails.logger.info("*** request uri: #{request_uri}")
    ead = get_ead(request_uri)
    Rails.logger.info("*** ead: \n #{ead}")

    xform = EadTransformer.new(ead, %w{ead2mods.xsl mods2csv.xsl})
    ead = xform.transform
    Pry::ColorPrinter.pp ead

  end

  private
  def get_ead(request_uri)
    respond_to do |format|
      format.html {
        self.response.headers['Last-Modified'] = Time.now.ctime.to_s

        self.response_body = Enumerator.new do |y|
          xml_response(request_uri, params) do |chunk, percent|
            y << chunk if !chunk.blank?
          end
        end
      }
    end
    self.response_body.to_s
  end

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
