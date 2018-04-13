<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns="http://www.loc.gov/mods/v3" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xpath-default-namespace="http://www.loc.gov/mods/v3"
	>
	<xsl:output method="text" encoding="utf-8" />
	
	<xsl:param name="delim" select="','" />
	<xsl:param name="quote" select="'&quot;'" />
	<xsl:param name="break" select="'&#xA;'" />
	
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="modsCollection">
		<xsl:text>"ID","Unit Title","Unit Date","Start Year","End Year","Unit ID","Level","Originator","Container 1","Container 2","Container 3","Phys. Desc. 1","Phys. Desc. 2","Phys. Desc. 3","Phys. Loc","Access Restrict.","URN","Collection Title","Originator","Collection Date","Collection ID","Parent 1","Parent 2","Parent 3","Parent 4","Parent 5","Parent 6"&#xA;</xsl:text>
		<xsl:apply-templates select="mods"/>
	</xsl:template>
	<xsl:template match="mods">
		<xsl:text>"</xsl:text><xsl:apply-templates select="recordInfo/recordIdentifier"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="titleInfo/title"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="originInfo/dateCreated[not(@point)]"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="originInfo/dateCreated[@point='start']"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="originInfo/dateCreated[@point='end']"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="identifier"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="physicalDescription/note[@type='organization']"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="name/namePart"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="physicalLocation[@type='container'][1]"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="physicalLocation[@type='container'][2]"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="physicalLocation[@type='container'][3]"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="physicalDescription[1]/extent"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="physicalDescription[2]/extent"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="physicalDescription[3]/extent"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="physicalLocation[@type='location']"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="accessCondition"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="location/url"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select=".//relatedItem[@displayLabel='collection']/titleInfo/title"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select=".//relatedItem[@displayLabel='collection']/name/namePart"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select=".//relatedItem[@displayLabel='collection']/originInfo/dateCreated[not(@point)]"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select=".//relatedItem[@displayLabel='collection']/identifier"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="./relatedItem[not(@displayLabel='collection')][1]/titleInfo/title"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="./relatedItem/relatedItem[not(@displayLabel='collection')]/titleInfo/title"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="./relatedItem/relatedItem/relatedItem[not(@displayLabel='collection')]/titleInfo/title"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="./relatedItem/relatedItem/relatedItem/relatedItem[not(@displayLabel='collection')]/titleInfo/title"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="./relatedItem/relatedItem/relatedItem/relatedItem/relatedItem[not(@displayLabel='collection')]/titleInfo/title"/><xsl:text>",</xsl:text>
		<xsl:text>"</xsl:text><xsl:apply-templates select="./relatedItem/relatedItem/relatedItem/relatedItem/relatedItem/relatedItem[not(@displayLabel='collection')]/titleInfo/title"/><xsl:text>",</xsl:text>

		<xsl:text>&#xA;</xsl:text>
	</xsl:template>
	
	<xsl:template match="*">
		<xsl:if test="not(.='')">
			<xsl:value-of select="normalize-space(replace(.,'&quot;','&quot;&quot;'))"/>
		</xsl:if>
	</xsl:template>
	
	
</xsl:stylesheet>
