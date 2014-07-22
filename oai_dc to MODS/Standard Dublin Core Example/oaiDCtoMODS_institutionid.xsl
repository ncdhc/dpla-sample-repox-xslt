<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:oai_dc='http://www.openarchives.org/OAI/2.0/oai_dc/' xmlns:dc="http://purl.org/dc/elements/1.1/" version="2.0" xmlns="http://www.loc.gov/mods/v3">
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  <xsl:template match="/oai_dc:dc">

    <mods xmlns="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd" version="3.4">      
      
      <xsl:apply-templates select="dc:title"/>
      <xsl:apply-templates select="dc:contributor"/>
      <xsl:apply-templates select="dc:coverage"/>
      <xsl:apply-templates select="dc:creator"/>
      
      <originInfo>
        <xsl:apply-templates select="dc:date"/>
        <xsl:apply-templates select="dc:publisher"/>
      </originInfo>
      
      <xsl:apply-templates select="dc:relation"/>
      <xsl:apply-templates select="dc:description"/>
      
      <physicalDescription>
      <xsl:apply-templates select="dc:format"/>
      </physicalDescription>
      
      <xsl:apply-templates select="dc:identifier" mode="identifier"/>
      <xsl:apply-templates select="dc:language"/>
      <xsl:apply-templates select="dc:rights"/>
      <xsl:apply-templates select="dc:subject"/>
      <xsl:apply-templates select="dc:type"/>

      <!-- This institution's reference url is in the 'identifier' field -->
      <xsl:for-each select="dc:identifier">
        <xsl:variable name="idvalue" select="normalize-space(.)"/>
        <xsl:if test="contains($idvalue,'http')"> 
          <location><url usage="primary display" access="object in context"><xsl:value-of select="$idvalue"/></url></location> <!-- ref url-->         
        </xsl:if>
      </xsl:for-each>
      
      <!-- This institution's thumbnail url is in the 'relation' field and contains string "_tn_" -->
      <xsl:for-each select="dc:relation">
        <xsl:for-each select="tokenize(.,';')">
          <xsl:variable name="relationvalue" select="normalize-space(.)"/>
          <xsl:if test="contains($relationvalue,'_tn_')"> 
            <location><url access="preview"><xsl:value-of select="$relationvalue"/></url></location> <!-- thumbnail url-->    
          </xsl:if>
        </xsl:for-each>
      </xsl:for-each>
      
      <!-- This institution's owning institution info is not available in the metadata -->
      <note type="ownership">Institution Name</note> <!-- owning institution -->
    </mods>
  </xsl:template>
  
  <!-- dublin core field templates -->
  <xsl:include href="oaidctomods_base.xsl"/>
  
</xsl:stylesheet>
