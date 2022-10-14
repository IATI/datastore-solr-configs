<?xml version='1.0' encoding='UTF-8'?>
<!-- Returns IATI XML from Solr XSLTResponseWriter Saxon HE -->
<xsl:stylesheet version='2.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
  <xsl:output media-type="text/xml" method="xml" indent="yes"/>

  <xsl:template match='/'>
    <iati-activities generated-datetime="{current-dateTime()}" version="2.03">
        <xsl:apply-templates select="response/result/doc"/>
    </iati-activities>
  </xsl:template>

  <xsl:template match="doc">
    <xsl:value-of disable-output-escaping="yes" select="str"/>
  </xsl:template>
</xsl:stylesheet>