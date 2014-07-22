<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:oai_dc='http://www.openarchives.org/OAI/2.0/oai_dc/' xmlns:dc="http://purl.org/dc/elements/1.1/" version="2.0" xmlns="http://www.loc.gov/mods/v3">
    
    <!-- This stylesheet produces Reference and Thumbnail URLs for new oai_dc CONTENTdm 6.5+ OAI feeds. It assumes:
        1) reference URL (of type [base_url]/cdm/ref/collection/[alias]/id/[pointer]) is stored in an <identifier> field
        2) thumbnail URL may be derived from the reference URL
    -->
    
    <xsl:output omit-xml-declaration="yes" indent="yes"/>
    
    <xsl:template match="dc:identifier" mode="locationurl">
        <xsl:variable name="idvalue" select="normalize-space(.)"/>
        <xsl:if test="starts-with($idvalue,'http')"> 
            <!-- CONTENTdm puts the URI in an <identifier> field in the OAI record -->
            <location><url usage="primary display" access="object in context"><xsl:value-of select="$idvalue"/></url></location> <!-- ref url-->          
            <!-- process identifier into CONTENTdm 6.5 thumbnail urls --> 
            <xsl:variable name="contentdmroot" select="substring-before($idvalue,'/cdm/ref/')"/>
            <xsl:variable name="recordinfo" select="substring-after($idvalue,'/cdm/ref/collection/')"/>
            <xsl:variable name="alias" select="substring-before($recordinfo,'/id/')"/>
            <xsl:variable name="pointer" select="substring-after($recordinfo,'/id/')"/>
            <location><url access="preview"><xsl:value-of select="concat($contentdmroot,'/utils/getthumbnail/collection/',$alias,'/id/',$pointer)"/></url></location> <!--CONTENTdm thumbnail url-->
            <!-- end CONTENTdm thumbnail url processing -->           
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>
