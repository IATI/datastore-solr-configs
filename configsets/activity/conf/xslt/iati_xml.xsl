<?xml version='1.0' encoding='UTF-8'?>
<!-- Returns IATI XML from Solr XSLTResponseWriter -->
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
  <xsl:output media-type="text/xml" method="xml" indent="yes"/>

  <xsl:template match='/'>
    <iati-activities generated-datetime="{response/result/doc/date[@name='datetime']}" version="2.03">
        <xsl:apply-templates select="response/result/doc"/>
    </iati-activities>
  </xsl:template>

  <xsl:template match="doc">
    <xsl:value-of disable-output-escaping="yes" select="str[@name='iati_xml']"/>
  </xsl:template>
</xsl:stylesheet>