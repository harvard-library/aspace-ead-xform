# generic EAD transformer.  Borrowed shamelessly from the work https://github.com/pobocks id in https://github.com/harvard-library/schematronium


require 'saxon-xslt'

class EadTransformer
  # constructor for the transformer
  # @param[String]ead  the EAD 
  # @param[Array[String]] xforms  an arbitrary length array of XSLT file names
  def initialize(ead, xforms)
    stages = xforms.map{|s| fetch_xsl s }
    Rails.logger.info("*** have #{stages.length} stages! ***")
  end

  private

  # Helper method returns stages of the XSLT transform
  # @param [String] fname The filename of a stage
  # @return [Saxon::XSLT::Stylesheet]
  def fetch_xsl(fname)
    Saxon.XSLT(File.open(File.join(File.dirname(File.expand_path(__FILE__)),'stylesheets', fname)))
  end

end
