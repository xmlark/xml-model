<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">
  
<xsl:import href="is-fo.xsl"/>

<xsl:template match="constraint">
  <fo:block font-weight="bold"><xsl:value-of select="title"/></fo:block>
  <fo:block margin-left="12pt"><xsl:apply-templates select="*[not(self::title)]"/></fo:block>
</xsl:template>

<xsl:template match="prod">
  <fo:block start-indent="24pt" space-after="12pt">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>
  
<xsl:template match="prod/grp[1]">
  <xsl:apply-templates/>
  <xsl:text> ::= </xsl:text>
</xsl:template>
  
<xsl:template match="referenced-document">
  <fo:block xsl:use-attribute-sets="para" id="{generate-id()}">
    <xsl:for-each select="*">
      <xsl:apply-templates select="." mode="field"/>
    </xsl:for-each>
  </fo:block>
</xsl:template>

<xsl:template match="abbrev" mode="field">
  <xsl:text>[</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>] </xsl:text>
</xsl:template>
  
<xsl:template match="url" mode="field">
  <xsl:text> Available at &lt;</xsl:text>
  <fo:basic-link external-destination="url('{.}')">
    <xsl:apply-templates/>
  </fo:basic-link>
  <xsl:text>&gt;</xsl:text>
</xsl:template>

<!-- HTML tabulky -->
<xsl:template match="table">

  <xsl:variable name="numcols">
    <xsl:call-template name="widest-html-row">
      <xsl:with-param name="rows" select=".//tr"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="prop-columns"
                select=".//col[contains(@width, '%')] |
                        .//colgroup[contains(@width, '%')]"/>

  <xsl:variable name="table.width">
  </xsl:variable>

  <fo:table space-after="12pt" border="solid 0.5pt black" border-collapse="collapse" table-layout="auto">
    <xsl:call-template name="make-html-table-columns">
      <xsl:with-param name="count" select="$numcols"/>
    </xsl:call-template>

    <xsl:apply-templates select="thead" mode="htmlTable"/>
    <xsl:apply-templates select="tfoot" mode="htmlTable"/>
    <xsl:choose>
      <xsl:when test="tbody">
        <xsl:apply-templates select="tbody" mode="htmlTable"/>
      </xsl:when>
      <xsl:otherwise>
        <fo:table-body start-indent="0pt" end-indent="0pt">
          <xsl:apply-templates select="tr" mode="htmlTable"/>
        </fo:table-body>
      </xsl:otherwise>
    </xsl:choose>
  </fo:table>

</xsl:template>

<!-- This template writes rowsep or colsep equivalant for html tables -->
<xsl:template name="html.table.cell.rules">
  <xsl:variable name="border" 
                select="(ancestor::table |
                         ancestor::informaltable)[last()]/@border"/>
  <xsl:variable name="table.rules"
                select="(ancestor::table |
                         ancestor::informaltable)[last()]/@rules"/>

  <xsl:variable name="rules">
    <xsl:choose>
      <xsl:when test="$table.rules != ''">
        <xsl:value-of select="$table.rules"/>
      </xsl:when>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$border != '' and $border != 0">
      <xsl:attribute name="border">solid 1pt black</xsl:attribute>
    </xsl:when>
    <xsl:when test="$rules = 'none'">
      <xsl:attribute name="border-start-style">none</xsl:attribute>
      <xsl:attribute name="border-end-style">none</xsl:attribute>
      <xsl:attribute name="border-top-style">none</xsl:attribute>
      <xsl:attribute name="border-bottom-style">none</xsl:attribute>
    </xsl:when>

    <xsl:when test="$rules = 'cols' and following-sibling::*">
      <!-- If not the last column, add border after -->
      <xsl:attribute name="border-start-style">none</xsl:attribute>
      <xsl:attribute name="border-top-style">none</xsl:attribute>
      <xsl:attribute name="border-bottom-style">none</xsl:attribute>
      <xsl:attribute name="border-end-style">style</xsl:attribute>
      <xsl:attribute name="border-end-width">1pt</xsl:attribute>
      <xsl:attribute name="border-end-color">black</xsl:attribute>
    </xsl:when>
    <!-- If not the last row, add border below -->
    <xsl:when test="$rules = 'rows'">
      <xsl:variable name="rowborder">
        <xsl:choose>
          <!-- If in thead and tbody has rows, add border -->
          <xsl:when test="parent::tr/parent::thead/
                          following-sibling::tbody/tr">1</xsl:when>
          <!-- If in tbody and tfoot has rows, add border -->
          <xsl:when test="parent::tr/parent::tbody/
                          following-sibling::tfoot/tr">1</xsl:when>
          <xsl:when test="parent::tr/parent::tbody/
                          preceding-sibling::tfoot/tr">1</xsl:when>
          <!-- If following rows, but not rowspan reaches last row -->
          <xsl:when test="parent::tr/following-sibling::tr and
             not(@rowspan = count(parent::tr/following-sibling::tr) + 1)">1</xsl:when>
          <xsl:otherwise>0</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:if test="$rowborder = 1">
        <xsl:attribute name="border-start-style">none</xsl:attribute>
        <xsl:attribute name="border-end-style">none</xsl:attribute>
        <xsl:attribute name="border-top-style">none</xsl:attribute>
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">1pt</xsl:attribute>
        <xsl:attribute name="border-bottom-color">black</xsl:attribute>
      </xsl:if>
    </xsl:when>
    <xsl:when test="$rules = 'all'">
      <xsl:attribute name="border-start-style">none</xsl:attribute>
      <xsl:attribute name="border-top-style">none</xsl:attribute>

      <xsl:variable name="rowborder">
        <xsl:choose>
          <!-- If in thead and tbody has rows, add border -->
          <xsl:when test="parent::tr/parent::thead/
                          following-sibling::tbody/tr">1</xsl:when>
          <!-- If in tbody and tfoot has rows, add border -->
          <xsl:when test="parent::tr/parent::tbody/
                          following-sibling::tfoot/tr">1</xsl:when>
          <xsl:when test="parent::tr/parent::tbody/
                          preceding-sibling::tfoot/tr">1</xsl:when>
          <!-- If following rows, but not rowspan reaches last row -->
          <xsl:when test="parent::tr/following-sibling::tr and
             not(@rowspan = count(parent::tr/following-sibling::tr) + 1)">1</xsl:when>
          <xsl:otherwise>0</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:if test="following-sibling::*">
        <!-- If not the last column, add border after -->
        <xsl:attribute name="border-end-style">solid</xsl:attribute>
        <xsl:attribute name="border-end-width">1pt</xsl:attribute>
        <xsl:attribute name="border-end-color">black</xsl:attribute>
      </xsl:if>
    </xsl:when>
    <xsl:when test="$rules = 'groups' and ancestor::thead 
                    and not(parent::tr/following-sibling::tr)">
      <xsl:attribute name="border-start-style">none</xsl:attribute>
      <xsl:attribute name="border-end-style">none</xsl:attribute>
      <xsl:attribute name="border-top-style">none</xsl:attribute>
      <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
      <xsl:attribute name="border-bottom-width">1pt</xsl:attribute>
      <xsl:attribute name="border-bottom-color">black</xsl:attribute>
    </xsl:when>
    <xsl:when test="$rules = 'groups' and ancestor::tfoot 
                    and not(parent::tr/preceding-sibling::tr)">
      <xsl:attribute name="border-start-style">none</xsl:attribute>
      <xsl:attribute name="border-end-style">none</xsl:attribute>
      <xsl:attribute name="border-top-style">none</xsl:attribute>
      <xsl:attribute name="border-top-style">solid</xsl:attribute>
      <xsl:attribute name="border-top-width">1pt</xsl:attribute>
      <xsl:attribute name="border-top-color">black</xsl:attribute>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="caption" mode="htmlTable">
  <!-- Handled by formal.object.heading -->
</xsl:template>

<xsl:template name="widest-html-row">
  <xsl:param name="rows" select="''"/>
  <xsl:param name="count" select="0"/>
  <xsl:choose>
    <xsl:when test="count($rows) = 0">
      <xsl:value-of select="$count"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$count &gt; count($rows[1]/*)">
          <xsl:call-template name="widest-html-row">
            <xsl:with-param name="rows" select="$rows[position() &gt; 1]"/>
            <xsl:with-param name="count" select="$count"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="widest-html-row">
            <xsl:with-param name="rows" select="$rows[position() &gt; 1]"/>
            <xsl:with-param name="count" select="count($rows[1]/*)"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="make-html-table-columns">
  <xsl:param name="count" select="0"/>
  <xsl:param name="number" select="1"/>

  <xsl:choose>
    <xsl:when test="col|colgroup/col">
      <xsl:for-each select="col|colgroup/col">
        <fo:table-column>
          <xsl:attribute name="column-number">
            <xsl:number from="table|informaltable" level="any" format="1"/>
          </xsl:attribute>
          <xsl:if test="@width">
            <xsl:attribute name="column-width">
                  <xsl:value-of select="@width"/>
            </xsl:attribute>
          </xsl:if>
        </fo:table-column>
      </xsl:for-each>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="tbody" mode="htmlTable">
  <fo:table-body start-indent="0pt"
                 end-indent="0pt">
    <xsl:apply-templates mode="htmlTable"/>
  </fo:table-body>
</xsl:template>

<xsl:template match="tfoot" mode="htmlTable">
  <fo:table-footer start-indent="0pt"
                   end-indent="0pt">
    <xsl:apply-templates mode="htmlTable"/>
  </fo:table-footer>
</xsl:template>

<xsl:template match="th|td" mode="htmlTable">

  <xsl:variable name="bgcolor">
    <xsl:choose>
      <xsl:when test="string-length(@bgcolor) != 0">
        <xsl:value-of select="@bgcolor"/>
      </xsl:when>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="align">
  </xsl:variable>

  <xsl:variable name="valign">
  </xsl:variable>

  <fo:table-cell  border="solid 0.5pt black" padding="2pt">

    <xsl:if test="@colspan &gt; 1">
      <xsl:attribute name="number-columns-spanned">
        <xsl:value-of select="@colspan"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:if test="@rowspan &gt; 1">
      <xsl:attribute name="number-rows-spanned">
        <xsl:value-of select="@rowspan"/>
      </xsl:attribute>
    </xsl:if>

    <fo:block>
      <xsl:apply-templates/>
    </fo:block>
  </fo:table-cell>
</xsl:template>

<xsl:template match="thead" mode="htmlTable">
  <fo:table-header start-indent="0pt"
                   end-indent="0pt">
    <xsl:apply-templates mode="htmlTable"/>
  </fo:table-header>
</xsl:template>

<xsl:template match="tr" mode="htmlTable">
  <fo:table-row>
    <xsl:apply-templates mode="htmlTable"/>
  </fo:table-row>
</xsl:template>

</xsl:stylesheet>
