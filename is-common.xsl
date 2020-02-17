<?xml version="1.0" encoding="iso-8859-1"?>
<!-- =================================================================

  Contains XSLT transforms common to the is-fo.xsl and is-html.xsl 
  stylesheets.

================================================================== -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- ===== SELF-REFERENCES ================================================== -->

  <xsl:template name="his">
    <!-- Up to date with ISO/IEC Directives, part 2, 2004, 5th ed -->
    <xsl:choose>
      <xsl:when test="/document/head/part-number">
        <xsl:text>his part of </xsl:text>
        <xsl:value-of select="/document/head/organization"/>
        <xsl:value-of select="/document/head/document-number"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>his International Standard</xsl:text> 
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="this" name="this">
    <xsl:text>t</xsl:text>
    <xsl:call-template name="his"/>
  </xsl:template>

  <xsl:template match="This">
    <xsl:text>T</xsl:text>
    <xsl:call-template name="his"/>
  </xsl:template>

  <!-- ===== VALIDATION OF NORMATIVE REFERENCES =============================== -->
  <xsl:template name="verify-normative-references">

    <xsl:for-each select="referenced-document">
      <xsl:variable name="id" select="@id"/>

      <xsl:if test="not(// clause // xref[@to = $id])">
	<xsl:message>ERROR: Normative reference <xsl:value-of select="$id"/> not referenced</xsl:message>
      </xsl:if>
    </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>