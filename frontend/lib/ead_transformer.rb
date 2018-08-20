# generic EAD transformer.  Borrowed shamelessly from the work https://github.com/pobocks id in https://github.com/harvard-library/schematronium


require 'saxon-xslt'

class EadTransformer
  # constructor for the transformer
  # @param[String]ead  the EAD
  # @param[Array[String]] xforms  an arbitrary length array of XSLT file names
  def initialize(ead, xforms)
    @stages = xforms.map{|s| fetch_xsl s }
     @ead = if ead.respond_to? :read
                   Saxon.XML(ead.read)
                 elsif ead.kind_of? String
                   if File.file? ead
                     Saxon.XML(File.open(ead))
                   else
                     Saxon.XML(ead)
                   end
                 else
                   raise "Unable to generate Ead document from #{ead.class.to_s}"
                 end
    Rails.logger.info("*** have #{@stages.length} stages! ***")
  end

  # stolen with permission from pobock's https://github.com/harvard-library/schematronium
  def transform()
    @stages.each do |stage|
#      Pry::ColorPrinter.pp stage
      @ead = stage.transform(@ead)
Rails.logger.debug("#{@ead.to_s.pretty_inspect}")
    end
    @ead.to_s
  end

  private

  # Helper method returns stages of the XSLT transform
  # @param [String] fname The filename of a stage
  # @return [Saxon::XSLT::Stylesheet]
  def fetch_xsl(fname)
Rails.logger.debug("FILE: #{File.join(File.dirname(File.expand_path(__FILE__)),'stylesheets', fname)}")
    Saxon.XSLT(File.open(File.join(File.dirname(File.expand_path(__FILE__)),'stylesheets', fname)))
  end

end
