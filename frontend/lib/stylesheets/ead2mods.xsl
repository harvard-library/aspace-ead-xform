<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="urn:isbn:1-931666-22-9"
    xmlns="http://www.loc.gov/mods/v3"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0">
    <xsl:output encoding="UTF-8" method="xml" indent="yes" omit-xml-declaration="yes"></xsl:output>
    <xsl:strip-space elements="*"/>
    <xsl:param name="eadid">hua04010</xsl:param>
    <!--<xsl:param name="componentid"/>-->
    
    <xsl:template match="ead">
        <modsCollection xmlns:xlink="http://www.w3.org/1999/xlink">
            <!--
            <xsl:apply-templates select="//c/did/unittitle"/>
            <xsl:apply-templates select="//c/did//unitdate"/>
            <xsl:apply-templates select="//c/did//persname"/>
            <xsl:apply-templates select="//c/did//famname"/>
            <xsl:apply-templates select="//c/did//corpname"/>
            <xsl:apply-templates select="//c/did//physdesc"/>
            <xsl:apply-templates select="//c/@level"/>
            <xsl:apply-templates select="//c/did//unitid"/>
            <xsl:apply-templates select="//c/did//container"/>
            <xsl:apply-templates select="archdesc/accessrestrict"/>
            <xsl:apply-templates select="//c/dao"/>
            <xsl:apply-templates select="//c/daogrp"/>
            <xsl:element name="recordInfo">
                <xsl:element name="recordIdentifier">
                    <xsl:value-of select="//c/@id"/>
                </xsl:element>
            </xsl:element>
            -->
            <xsl:apply-templates select="//c" mode="withmods"/>
        </modsCollection>
    </xsl:template>

    <xsl:template match="c" mode="withmods">
        <mods>
            <xsl:apply-templates select="did/unittitle"/>
            <xsl:apply-templates select="did//unitdate"/>
            <xsl:apply-templates select="did//origination"/>
            <xsl:apply-templates select="did//physdesc"/>
            <xsl:apply-templates select="did//physloc"/>
            <xsl:apply-templates select="@level"/>
            <xsl:apply-templates select="did//unitid"/>
            <xsl:apply-templates select="did//container"/>
            <xsl:apply-templates select="accessrestrict"/>
            <xsl:apply-templates select="dao"/>
            <xsl:apply-templates select="did/dao"/>
            <xsl:apply-templates select="daogrp"/>
            <xsl:apply-templates select="did/daogrp"/>
            <xsl:element name="recordInfo">
                <xsl:element name="recordIdentifier">
                    <!--xsl:value-of select="@id"/-->
                    <xsl:apply-templates select="@id"/>
                </xsl:element>
            </xsl:element>
            <relatedItem>
                <xsl:attribute name="type">host</xsl:attribute>
                <xsl:if test="parent::c">
                    <xsl:apply-templates select="parent::c/did/unittitle"/>
                    <xsl:apply-templates select="parent::c/did//unitdate"/>
                    <xsl:element name="recordInfo">
                        <xsl:element name="recordIdentifier">
                            <xsl:apply-templates select="parent::c/@id"/>
                            <!--xsl:value-of select="parent::c/@id"/ -->
                        </xsl:element>
                    </xsl:element>
                    <xsl:apply-templates select="parent::c" mode="withoutmods"/>
                </xsl:if>
                
                <xsl:if test="not(parent::c)">
                    <xsl:attribute name="displayLabel">collection</xsl:attribute>
                    <xsl:apply-templates select="/ead/archdesc/did//repository"/>
                    <xsl:apply-templates select="/ead/archdesc/did//unitid"/>
                    <xsl:apply-templates select="/ead/archdesc/did/origination"/>
                    <xsl:apply-templates select="/ead/archdesc/did/unittitle"/>
                    <xsl:apply-templates select="/ead/archdesc/did//unitdate"/>
                    <xsl:element name="recordInfo">
                        <xsl:element name="recordIdentifier">
                            <xsl:value-of select="/ead/eadheader/eadid"/>
                        </xsl:element>
                    </xsl:element>
                </xsl:if>
                
            </relatedItem>
        </mods>    
    </xsl:template>
    <xsl:template match="c" mode="withoutmods">
        <!--
            <xsl:apply-templates select="did/unittitle"/>
            <xsl:apply-templates select="did//unitdate"/>
            <xsl:apply-templates select="did//persname"/>
            <xsl:apply-templates select="did//famname"/>
            <xsl:apply-templates select="did//corpname"/>
            <xsl:apply-templates select="did//physdesc"/>
            <xsl:apply-templates select="@level"/>
            <xsl:apply-templates select="did//unitid"/>
            <xsl:apply-templates select="did//container"/>
            <xsl:apply-templates select="/ead/archdesc/accessrestrict"/>
            <xsl:apply-templates select="dao"/>
            <xsl:apply-templates select="daogrp"/>
            <xsl:element name="recordInfo">
                <xsl:element name="recordIdentifier">
                    <xsl:value-of select="@id"/>
                </xsl:element>
            </xsl:element>
            -->
            <relatedItem>
                <xsl:attribute name="type">host</xsl:attribute>
                <xsl:if test="parent::c">
                    <xsl:apply-templates select="parent::c/did/unittitle"/>
                    <xsl:apply-templates select="parent::c/did//unitdate"/>
                    <xsl:element name="recordInfo">
                        <xsl:element name="recordIdentifier">
                            <xsl:value-of select="parent::c/@id"/>
                        </xsl:element>
                    </xsl:element>
                    <xsl:apply-templates select="parent::c" mode="withoutmods"/>
                </xsl:if>
                
                <xsl:if test="not(parent::c)">
                	<xsl:attribute name="displayLabel">collection</xsl:attribute>
                       <xsl:apply-templates select="/ead/archdesc/did//repository"/>
                        <xsl:apply-templates select="/ead/archdesc/did//unitid"/>
                        <xsl:apply-templates select="/ead/archdesc/did/origination"/>
                        <xsl:apply-templates select="/ead/archdesc/did/unittitle"/>
                        <xsl:apply-templates select="/ead/archdesc/did//unitdate"/>
                        <xsl:element name="recordInfo">
                            <xsl:element name="recordIdentifier">
                                <xsl:value-of select="/ead/eadheader/eadid"/>
                            </xsl:element>
                        </xsl:element>
                </xsl:if>
            </relatedItem>
            
    </xsl:template>
    <xsl:template match="@id[starts-with(., 'aspace_') and not(string-length(substring-after(.,'_')) = 32)]">
         <xsl:value-of select="substring-after(., 'aspace_')"/>
        
    </xsl:template>
    
    <xsl:template match="unittitle">
        <xsl:element name="titleInfo">
            <xsl:element name="title">        
                <xsl:value-of select="normalize-space(replace(.,'\n',' '))"/>
            </xsl:element>
        </xsl:element>       
    </xsl:template>
    <xsl:template match="unitdate">
        <xsl:element name="originInfo">
            <xsl:if test='@normal'>
                <xsl:element name="dateCreated">
                    <xsl:attribute name="point">start</xsl:attribute>
                    <xsl:value-of select="substring-before(@normal,'/')"/>
                </xsl:element>               

                <xsl:element name="dateCreated">
                    <xsl:attribute name="point">end</xsl:attribute>
                    <xsl:value-of select="substring-after(@normal,'/')"/>
                </xsl:element>               
            </xsl:if>
            <xsl:element name="dateCreated">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="persname|famname|corpname">
        <xsl:element name="name">
            <xsl:element name="namePart">
                <xsl:value-of select="normalize-space(replace(.,'\n',' '))"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>       

    <xsl:template match="origination">
        <xsl:element name="name">
            <xsl:element name="namePart">
                <xsl:value-of select="normalize-space(replace(.,'\n',' '))"/>
            </xsl:element>
        </xsl:element>
    </xsl:template> 

    <xsl:template match="physdesc">
        <xsl:element name="physicalDescription">
            <xsl:element name="extent">
                <xsl:value-of select="normalize-space(replace(.,'\n',' '))"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="extent">
        <xsl:element name="physicalDescription">
            <xsl:element name="extent">
                <xsl:value-of select="normalize-space(replace(.,'\n',' '))"/>
            </xsl:element>
        </xsl:element>
    </xsl:template> 
 
    <xsl:template match="@level">
        <xsl:element name="physicalDescription">
            <xsl:element name="note">
                <xsl:attribute name="type"><xsl:text>organization</xsl:text></xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
 
    <xsl:template match="unitid">
        <xsl:element name="identifier">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template> 

    <xsl:template match="container">
        <xsl:element name="physicalLocation">
            <xsl:attribute name="type"><xsl:text>container</xsl:text></xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template> 

    <xsl:template match="physloc">
        <xsl:element name="physicalLocation">
            <xsl:attribute name="type"><xsl:text>location</xsl:text></xsl:attribute>
            <xsl:value-of select="normalize-space(replace(.,'\n',' '))"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="repository">
        <xsl:element name="location">
	    <xsl:element name="physicalLocation">	
                <xsl:attribute name="type"><xsl:text>repository</xsl:text></xsl:attribute>
                <xsl:value-of select="normalize-space(.)"/>
                <!--<xsl:if test="./*">
                    <xsl:value-of select="./*"/>
                </xsl:if>-->
            </xsl:element>
        </xsl:element>
    </xsl:template> 

    <xsl:template match="accessrestrict">
        <xsl:element name="accessCondition">
            <xsl:value-of select="replace(.,'\n',' ')"/>
        </xsl:element>
    </xsl:template> 
 
    <xsl:template match="dao">
        <xsl:element name="location">
            <xsl:element name="url">
                <xsl:value-of select="@href"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="daogrp">
        <xsl:element name="location">
            <xsl:apply-templates select="daoloc[@xlink:label=../arc/@xlink:to[../@xlink:show='embed']]"/>
            <xsl:apply-templates select="daoloc[@xlink:label=../arc/@xlink:to[../@xlink:show='new']]"/>
            <!--<xsl:element name="location">
            <xsl:element name="url">
                <xsl:value-of select="daoloc/@href"/>
            </xsl:element>
        </xsl:element>-->
        </xsl:element>    
    </xsl:template>
    
    <xsl:template match="daoloc[@xlink:label=../arc/@xlink:to[../@xlink:show='embed']]">
        <xsl:element name="url">
            <xsl:attribute name="displayLabel">Thumbnail</xsl:attribute>
            <xsl:value-of select="@href"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="daoloc[@xlink:label=../arc/@xlink:to[../@xlink:show='new']]">
        <xsl:element name="url">
            <xsl:attribute name="displayLabel">Full Image</xsl:attribute>
            <xsl:value-of select="@href"/>
        </xsl:element>
    </xsl:template> 
    <!--
    <xsl:template match="daogrp">
        <xsl:element name="location">
            <xsl:element name="url">
                <xsl:value-of select="substring-before(daoloc[1]/@href,'?')"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    -->
</xsl:stylesheet>
