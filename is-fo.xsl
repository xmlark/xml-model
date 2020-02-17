<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY emdash "&#x2014;">
<!ENTITY langle "&#x3008;">
<!ENTITY rangle "&#x3009;">
]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  extension-element-prefixes="p"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:p="http://relaxng.org/ns/proofsystem">

<xsl:include href="is-common.xsl"/>
<xsl:output encoding="utf-8"/>

<xsl:key name="id" match="clause|annex|referenced-document|li|
                          terms-and-definitions" use="@id"/>

<xsl:variable name="head" select="/document/head"/>

<xsl:template match="head">

  <fo:block text-align="right" font-size="12pt" font-weight="bold" space-after="11pt">
    <xsl:value-of select="organization"/>
    <xsl:text> </xsl:text>
    <xsl:if test="$head/tc-number=1">J</xsl:if>
    <xsl:text>TC </xsl:text>
    <xsl:value-of select="tc-number"/>
    <xsl:text>/SC </xsl:text>
    <xsl:value-of select="sc-number"/>
  </fo:block>
  <fo:block text-align="right" white-space-collapse="false" space-after="11pt">
    <xsl:text>Date:   </xsl:text>
    <xsl:value-of select="date"/>
  </fo:block>
  <fo:block text-align="right" font-size="12pt" font-weight="bold" space-before="22pt">
    <xsl:call-template name="document-number"/>
  </fo:block>
  <fo:block text-align="right" space-before="22pt">
    <xsl:value-of select="organization"/>
    <xsl:text> </xsl:text>
    <xsl:if test="$head/tc-number=1">J</xsl:if>
    <xsl:text>TC </xsl:text>
    <xsl:value-of select="tc-number"/>
    <xsl:text>/SC </xsl:text>
    <xsl:value-of select="sc-number"/>
    <xsl:text>/WG </xsl:text>
    <xsl:value-of select="wg-number"/>
  </fo:block>
  <fo:block text-align="right" white-space-collapse="false" space-before="11pt">
    <xsl:text>Secretariat:   </xsl:text>
    <xsl:value-of select="secretariat"/>
  </fo:block>
  <fo:block text-align="left" space-before="100pt" font-weight="bold" font-size="14pt" line-height="15.5pt">
    <xsl:call-template name="std-title"/>
  </fo:block>

  <fo:block space-before="68pt" border-style="solid" border-width=".75pt" 
	    padding-left="4pt" padding-right="4pt" padding-top="1pt" 
	    padding-bottom="1pt" text-align="left">

    <fo:block text-align="center" font-weight="bold">Warning</fo:block>

    <fo:block space-before="11pt">This document is not an ISO
International Standard. It is distributed for review and comment. It
is subject to change without notice and may not be referred to as an
International Standard.</fo:block>

    <fo:block space-before="11pt">Recipients of this document are
invited to submit, with their comments, notification of any relevant
patent rights of which they are aware and to provide supporting
documentation.</fo:block>

   </fo:block>

<fo:block break-before="page">
   <fo:block border-style="solid" border-width=".5pt" padding-left="4pt" padding-right="4pt" padding-top="1pt" padding-bottom="1pt" break-before="page">
<fo:block text-align="center" font-weight="bold" font-size="12pt" line-height="13.5pt" space-after="10pt">Copyright notice</fo:block>

<fo:block space-after="11.5pt">This ISO document is a Draft International Standard and is
copyright-protected by ISO. Except as permitted under the applicable
laws of the user's country, neither this ISO draft nor any extract
from it may be reproduced, stored in a retrieval system or transmitted
in any form or by any means, electronic, photocopying, recording or
otherwise, without prior written permission being secured.</fo:block>

<fo:block space-after="6pt">Requests for permission to reproduce should
be addressed to either ISO at the address below or ISO's member body
in the country of the requester.</fo:block>

<fo:wrapper start-indent=".71cm" white-space-collapse="false">
<fo:block>ISO copyright office</fo:block>
<fo:block>Case postale 56 · CH-1211 Geneva 20</fo:block>
<fo:block>Tel.  + 41 22 749 01 11</fo:block>
<fo:block>Fax  + 41 22 749 09 47</fo:block>
<fo:block>E-mail  copyright@iso.ch</fo:block>
<fo:block space-after="11.5pt">Web  www.iso.ch</fo:block>
</fo:wrapper>

<fo:block space-after="11.5pt">Reproduction may be subject to royalty
payments or a licensing agreement.</fo:block>

<fo:block>Violators may be prosecuted.</fo:block>
</fo:block>
</fo:block>
</xsl:template>

<xsl:template match="foreword">
  <fo:block xsl:use-attribute-sets="Heading1" id="{generate-id()}" break-before="page">Foreword</fo:block>

<fo:block xsl:use-attribute-sets="para">ISO (the International Organization for
Standardization) and IEC (the International Electrotechnical
Commission) form the specialized system for worldwide
standardization. National bodies that are members of ISO or IEC
participate in the development of International Standards through
technical committees established by the respective organization to
deal with particular fields of technical activity. ISO and IEC
technical committees collaborate in fields of mutual interest. Other
international organizations, governmental and non-governmental, in
liaison with ISO and IEC, also take part in the work. In the field of
information technology, ISO and IEC have established a joint technical
committee, ISO/IEC JTC 1.</fo:block>

<fo:block xsl:use-attribute-sets="para">International Standards are
drafted in accordance with the rules given in the ISO/IEC Directives,
Part 2.</fo:block>

<fo:block xsl:use-attribute-sets="para">
  <xsl:value-of select="$head/organization"/>
  <xsl:text> </xsl:text>
  <xsl:value-of select="$head/document-number"/>
  <xsl:if test="$head/part-number">
    <xsl:text>-</xsl:text>
    <xsl:value-of select="$head/part-number"/>
  </xsl:if>
  <xsl:text> was prepared by </xsl:text>
  <xsl:if test="$head/tc-number=1">Joint </xsl:if>
  <xsl:text>Technical Committee </xsl:text>
  <xsl:value-of select="$head/organization"/>
  <xsl:text> </xsl:text>
  <xsl:if test="$head/tc-number=1">J</xsl:if>
  <xsl:text>TC </xsl:text>
  <xsl:value-of select="$head/tc-number"/>
  <xsl:text>, </xsl:text>
  <fo:wrapper font-style="italic">
    <xsl:value-of select="$head/tc-name"/>
  </fo:wrapper>
  <xsl:text>, Subcommittee SC </xsl:text>
  <xsl:value-of select="$head/sc-number"/>
  <xsl:text>, </xsl:text>
  <xsl:value-of select="$head/sc-name"/>
  <xsl:text>.</xsl:text>
</fo:block>
  <xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="part-list">
  <fo:block xsl:use-attribute-sets="para">
    <xsl:value-of select="$head/organization"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$head/document-number"/>
    <xsl:text> consists of the following parts, under the general title </xsl:text>
    <fo:wrapper font-style="italic">
      <xsl:if test="$head/title/introductory">
	<xsl:value-of select="$head/title/introductory"/>
	<xsl:text> &emdash; </xsl:text>
      </xsl:if>
      <xsl:value-of select="$head/title/main"/>
    </fo:wrapper>
    <xsl:text>:</xsl:text>
  </fo:block>
  <fo:list-block>
    <xsl:for-each select="part">
      <fo:list-item xsl:use-attribute-sets="para">
	<fo:list-item-label end-indent="label-end()">
	  <fo:block>&emdash;</fo:block>
	</fo:list-item-label>
	<fo:list-item-body start-indent="body-start()">
	  <fo:block font-style="italic">
	    <xsl:text>Part </xsl:text>
	    <xsl:value-of select="number"/>
	    <xsl:text>: </xsl:text>
	    <xsl:value-of select="title"/>
	  </fo:block>
	</fo:list-item-body>
      </fo:list-item>
    </xsl:for-each>
  </fo:list-block>
</xsl:template>

<xsl:template match="introduction"> 
  <fo:block xsl:use-attribute-sets="Heading1"  id="{generate-id()}" break-before="page">Introduction</fo:block>
  <xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template name="std-title">
  <xsl:if test="$head/title/introductory">
    <xsl:value-of select="$head/title/introductory"/>
    <xsl:text> &emdash; </xsl:text>
  </xsl:if>
  <xsl:value-of select="$head/title/main"/>
  <xsl:if test="$head/title/complementary">
    <xsl:text> &emdash; </xsl:text>
    <xsl:if test="$head/part-number">
      <xsl:text>Part </xsl:text>
      <xsl:value-of select="$head/part-number"/>
      <xsl:text>: </xsl:text>
    </xsl:if>
    <xsl:value-of select="$head/title/complementary"/>
  </xsl:if>
</xsl:template>

<xsl:template name="document-number">
  <xsl:value-of select="$head/organization"/>
  <xsl:text> </xsl:text>
  <xsl:choose>
    <xsl:when test="$head/stage='preparatory'">WD </xsl:when>
    <xsl:when test="$head/stage='committee'">CD </xsl:when>
    <xsl:when test="$head/stage='committee-final'">FCD </xsl:when>
    <xsl:when test="$head/stage='enquiry'">DIS </xsl:when>
    <xsl:when test="$head/stage='approval'">FDIS </xsl:when>
    <xsl:otherwise/>
  </xsl:choose>
  <xsl:value-of select="$head/document-number"/>
  <xsl:if test="$head/part-number">
    <xsl:text>-</xsl:text>
    <xsl:value-of select="$head/part-number"/>
  </xsl:if>
</xsl:template>

<xsl:template match="scope">
  <fo:block xsl:use-attribute-sets="STDTitle">
    <xsl:call-template name="std-title"/>
  </fo:block>
  <xsl:call-template name="numbered-clause">
    <xsl:with-param name="content">Scope</xsl:with-param>
  </xsl:call-template>
  <xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="normative-references">
  <xsl:call-template name="numbered-clause">
    <xsl:with-param name="content">Normative references</xsl:with-param>
  </xsl:call-template>
<xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="terms-and-definitions">
  <xsl:call-template name="numbered-clause">
    <xsl:with-param name="content">Terms and definitions</xsl:with-param>
  </xsl:call-template>

  <fo:block xsl:use-attribute-sets="para">For the purposes of
  <xsl:call-template name="this"/>, the following terms and
  definitions apply.</fo:block>

  <xsl:apply-templates/>

  <xsl:for-each select="//termdef">
    <xsl:sort select="term"/>

    <fo:block xsl:use-attribute-sets="para">
      <fo:block font-weight="bold">3.<xsl:number value="position()"/></fo:block>
      <fo:block font-weight="bold"><xsl:value-of select="term"/></fo:block>
    </fo:block>
  
    <fo:block xsl:use-attribute-sets="para"
	     ><xsl:apply-templates select="def"/></fo:block>
  </xsl:for-each>

</xsl:template>

<xsl:template match="term-and-definition">
  <fo:block font-weight="bold" keep-with-next="always">
    <xsl:for-each select="..">
      <xsl:call-template name="clause-number"/>
    </xsl:for-each>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="position()"/>
  </fo:block>
  <xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="term-and-definition/term[1]" priority="1">
  <fo:block font-weight="bold" keep-with-next="always">
    <xsl:value-of select="."/>
  </fo:block>
</xsl:template>

<xsl:template match="term-and-definition/term">
  <fo:block keep-with-next="always">
    <xsl:value-of select="."/>
    <xsl:if test="@status">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="@status"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
  </fo:block>
</xsl:template>

<xsl:template match="term-and-definition/definition">
  <fo:block xsl:use-attribute-sets="para">
    <xsl:if test="@subject-field">
      <xsl:text>&langle;</xsl:text>
      <xsl:value-of select="@subject-field"/>
      <xsl:text>&rangle;</xsl:text>
      <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="clause">
  <xsl:call-template name="numbered-clause">
    <xsl:with-param name="content"><xsl:apply-templates select="title"/></xsl:with-param>
  </xsl:call-template>
  <xsl:apply-templates select="*[not(self::title)]"/>
</xsl:template>

<xsl:template name="numbered-clause">
  <xsl:param name="content"/>
  <xsl:variable name="level" select="count(ancestor::*)"/>
  <xsl:choose>
    <xsl:when test="$level=1">
      <fo:list-block xsl:use-attribute-sets="Heading1">
        <fo:list-item keep-with-next="always">
          <fo:list-item-label>
            <fo:block id="{generate-id()}">
	      <xsl:call-template name="clause-number"/>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body>
            <fo:block start-indent=".71cm">
	      <xsl:copy-of select="$content"/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </fo:list-block>
    </xsl:when>
    <xsl:when test="$level=2">
      <fo:list-block xsl:use-attribute-sets="Heading2">
        <fo:list-item keep-with-next="always">
          <fo:list-item-label>
            <fo:block id="{generate-id()}">
	      <xsl:call-template name="clause-number"/>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body>
            <fo:block start-indent=".95cm">
	      <xsl:copy-of select="$content"/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </fo:list-block>
    </xsl:when>
    <xsl:otherwise>
      <fo:list-block xsl:use-attribute-sets="Heading3">
        <fo:list-item keep-with-next="always">
          <fo:list-item-label>
            <fo:block id="{generate-id()}">
	      <xsl:call-template name="clause-number"/>
            </fo:block>
          </fo:list-item-label>
          <fo:list-item-body>
            <fo:block start-indent="{1.16 + ($level - 3)*.5}cm">
	      <xsl:copy-of select="$content"/>
            </fo:block>
          </fo:list-item-body>
        </fo:list-item>
      </fo:list-block>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<xsl:template name="clause-number">
  <xsl:choose>
    <xsl:when test="ancestor::annex">
      <xsl:number count="annex" format="A"/>
      <xsl:text>.</xsl:text>
      <xsl:number count="clause" level="multiple" format="1.1"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:number count="scope|normative-references|terms-and-definitions|clause" level="multiple" format="1.1"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="p">
  <fo:block xsl:use-attribute-sets="para"><xsl:apply-templates/></fo:block>
</xsl:template>

<xsl:template match="ednote">
  <fo:block margin-left="12pt" font-weight="bold">Ed. Note.</fo:block>
  <fo:block margin-left="12pt"><xsl:apply-templates/></fo:block>
</xsl:template>

<xsl:template match="constraint">
  <fo:block font-weight="bold">Constraint: <xsl:value-of select="title"/></fo:block>
  <fo:block margin-left="12pt"><xsl:apply-templates select="p"/></fo:block>
</xsl:template>

<xsl:template match="issue">
  <fo:block margin-left="12pt" font-weight="bold">Issue (<xsl:value-of select="@id"/>)</fo:block>
  <fo:block margin-left="12pt"><xsl:apply-templates/></fo:block>
</xsl:template>

<xsl:variable name="pre-font">Arial</xsl:variable>

<xsl:attribute-set name="pre">
  <xsl:attribute name="white-space-collapse">false</xsl:attribute>
  <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
  <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
  <xsl:attribute name="wrap-option">no-wrap</xsl:attribute>
  <xsl:attribute name="text-align">left</xsl:attribute>
  <xsl:attribute name="font-family"><xsl:value-of select="$pre-font"/></xsl:attribute>
  <xsl:attribute name="start-indent">.71cm</xsl:attribute>
</xsl:attribute-set>

<xsl:template match="pre">
  <fo:block xsl:use-attribute-sets="pre para">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="note/p[1]">
  <fo:list-block xsl:use-attribute-sets="Note">
    <fo:list-item>
      <fo:list-item-label>
	<fo:block>
          <xsl:text>NOTE</xsl:text>
          <xsl:if test="count((ancestor::clause|ancestor::introduction|ancestor::normative-references|ancestor::annex|ancestor::terms-and-definition)[last()]//note)&gt;1">
            <xsl:text> </xsl:text>
            <xsl:number count="note" level="any"
                       from="clause|introduction|normative-references|annex|terms-and-definition"/>
          </xsl:if>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body>
	<fo:block text-indent="1.69cm">
          <xsl:apply-templates/>
	</fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </fo:list-block>
</xsl:template>

  <!-- Published subjects -->
  <xsl:template match="published-subjects">
    <xsl:variable name="prefix" select="@prefix"/>

    <xsl:for-each select="//termdef">
      <xsl:sort select="term"/>

      <xsl:variable name="name" select='translate(normalize-space(term), " ", "-")'/>

      <fo:block>
        <fo:wrapper font-weight="bold">
          <xsl:value-of select="term"/>
        </fo:wrapper>
      </fo:block>
      
      <fo:block xsl:use-attribute-sets="para" margin-left="24pt">
        <xsl:value-of select="$prefix"/><xsl:value-of select="$name"/>
      </fo:block>
    </xsl:for-each>
  </xsl:template>

<xsl:template match="example|note">
  <fo:wrapper font-size="9pt">
    <xsl:apply-templates/>
  </fo:wrapper>
</xsl:template>

<xsl:template match="example/p[1]">
  <fo:list-block xsl:use-attribute-sets="Note">
    <fo:list-item>
      <fo:list-item-label>
	<fo:block>
          <xsl:text>EXAMPLE</xsl:text>
          <xsl:if test="count((ancestor::clause|ancestor::introduction|ancestor::normative-references|ancestor::annex|ancestor::terms-and-definition)[last()]//example)&gt;1">
            <xsl:text> </xsl:text>
            <xsl:number count="example" level="any"
                       from="clause|introduction|normative-references|annex|terms-and-definition"/>
          </xsl:if>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body>
	<fo:block text-indent="1.99cm">
          <xsl:apply-templates/>
	</fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </fo:list-block>
</xsl:template>

<xsl:template match="example/ul | example/ol | eqrule/ul | eqrule/ol">
  <fo:list-block margin-left="12pt">
    <xsl:apply-templates select="*"/>
  </fo:list-block>
</xsl:template>

<xsl:template match="ul|ol">
  <fo:list-block margin-left="12pt">
    <xsl:apply-templates select="*"/>
  </fo:list-block>
</xsl:template>

<xsl:template match="ul/li">
  <fo:list-item>
    <fo:list-item-label end-indent="label-end()">
       <fo:block>&emdash;</fo:block>
    </fo:list-item-label>
    <fo:list-item-body start-indent="body-start()">
      <xsl:apply-templates select="*"/>
    </fo:list-item-body>
  </fo:list-item>
</xsl:template>

<xsl:template match="ol/li">
  <fo:list-item>
    <fo:list-item-label end-indent="label-end()">
       <fo:block><xsl:number/>.</fo:block>
    </fo:list-item-label>
    <fo:list-item-body start-indent="body-start()">
      <xsl:apply-templates select="*"/>
    </fo:list-item-body>
  </fo:list-item>
</xsl:template>

<xsl:template match="dt">
  <fo:block>
    <fo:wrapper font-weight="bold">
      <xsl:apply-templates/>
    </fo:wrapper>
  </fo:block>
</xsl:template>

<xsl:template match="dd">
  <fo:block xsl:use-attribute-sets="para" margin-left="24pt">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="url" mode="field">
  <xsl:text>available at &lt;</xsl:text>
  <fo:basic-link external-destination="url('{.}')">
    <xsl:apply-templates/>
  </fo:basic-link>
  <xsl:text>&gt;</xsl:text>
</xsl:template>

<xsl:template match="title" mode="field">
  <fo:wrapper font-style="italic"><xsl:apply-templates/></fo:wrapper>
</xsl:template>

<xsl:template match="var | i">
  <fo:wrapper font-style="italic"><xsl:apply-templates/></fo:wrapper>
</xsl:template>

<xsl:template match="code | el">
  <fo:wrapper font-family="{$pre-font}"><xsl:apply-templates/></fo:wrapper>
</xsl:template>

<xsl:template match="term | em">
  <fo:wrapper font-style="italic"><xsl:apply-templates/></fo:wrapper>
</xsl:template>

<xsl:template match="xref">
  <xsl:apply-templates select="key('id',@to)" mode="xref"/>
</xsl:template>

<xsl:template match="Xref">
  <xsl:apply-templates select="key('id',@to)" mode="Xref"/>
</xsl:template>

<xsl:template match="*" mode="Xref">
  <xsl:apply-templates mode="xref" select="."/>
</xsl:template>

<xsl:template match="clause//clause|annex//clause" mode="xref">
  <fo:basic-link internal-destination="{generate-id()}">
    <xsl:call-template name="clause-number"/>
  </fo:basic-link>
</xsl:template>

<xsl:template match="clause" mode="xref">
  <fo:basic-link internal-destination="{generate-id()}">
    <xsl:text>Clause </xsl:text>
    <xsl:call-template name="clause-number"/>
  </fo:basic-link>
</xsl:template>

<xsl:template match="annex" mode="xref">
  <fo:basic-link internal-destination="{generate-id()}">
    <xsl:text>Annex </xsl:text>
    <xsl:number format="A"/>
  </fo:basic-link>
</xsl:template>

<xsl:template match="terms-and-definitions" mode="xref">
  <fo:basic-link internal-destination="{generate-id()}">
    <xsl:text>Clause 3</xsl:text> <!-- it's always #3 -->
  </fo:basic-link>
</xsl:template>


<xsl:template match="referenced-document" mode="xref">
  <fo:basic-link internal-destination="{generate-id()}">
    <fo:wrapper font-style="italic">[<xsl:value-of select="abbrev"/>]</fo:wrapper>
  </fo:basic-link>
</xsl:template>

<xsl:template match="referenced-document">
  <fo:block xsl:use-attribute-sets="para" id="{generate-id()}">
    <xsl:for-each select="*">
      <xsl:if test="not(position()=1)">, </xsl:if>
      <xsl:apply-templates select="." mode="field"/>
    </xsl:for-each>
  </fo:block>
</xsl:template>

<xsl:template match="annex">
<fo:block xsl:use-attribute-sets="ANNEX" break-before="page">
<xsl:text>Annex </xsl:text>
<xsl:number format="A"/>
</fo:block>

<fo:block xsl:use-attribute-sets="ANNEX" font-weight="normal">
<xsl:text>(</xsl:text>
<xsl:choose>
  <xsl:when test="@normative='true'">normative</xsl:when>
  <xsl:otherwise>informative</xsl:otherwise>
</xsl:choose>
<xsl:text>)</xsl:text>
</fo:block>
<fo:block xsl:use-attribute-sets="ANNEX" space-before="15.5pt" space-after="38pt" id="{generate-id()}">
<xsl:apply-templates select="title"/>
</fo:block>
<xsl:apply-templates select="*[not(self::title)]"/>
</xsl:template>

<xsl:template match="bibliography">

<fo:block xsl:use-attribute-sets="ANNEX" break-before="page" space-after="38pt" id="{generate-id()}">
<xsl:text>Bibliography</xsl:text>
</fo:block>

<fo:list-block provisional-distance-between-starts="1.16cm">
  <xsl:for-each select="referenced-document">
    <fo:list-item xsl:use-attribute-sets="para" id="{generate-id()}">
      <fo:list-item-label end-indent="label-end()">
	 <fo:block>[<xsl:value-of select="position()"/>]</fo:block>
      </fo:list-item-label>
      <fo:list-item-body start-indent="body-start()">
	<fo:block>
	  <xsl:for-each select="*[not(self::abbrev)]">
	    <xsl:if test="not(position()=1)">, </xsl:if>
	    <xsl:apply-templates select="." mode="field"/>
	  </xsl:for-each>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:for-each>
</fo:list-block>
</xsl:template>

<xsl:template match="notation-list">
  <fo:list-block>
    <xsl:for-each select="notation-item">
      <fo:list-item xsl:use-attribute-sets="para">
        <fo:list-item-label end-indent="label-end()">
          <fo:block>&emdash;</fo:block>
        </fo:list-item-label>
        <fo:list-item-body start-indent="body-start()">
          <fo:block>
   	    <xsl:apply-templates select="notation"/>
	    <xsl:text> </xsl:text>
	    <xsl:apply-templates select="notation-definition/p[1]/node()"/>
          </fo:block>
	  <xsl:apply-templates select="notation-definition/*[position()!=1]"/>
        </fo:list-item-body>
      </fo:list-item>
    </xsl:for-each>
  </fo:list-block>
</xsl:template>

<xsl:template match="p:*"/>

<xsl:template match="graphic">
  <fo:block xsl:use-attribute-sets="para">
    <fo:external-graphic content-type="content-type:image/png" 
                         src="url('{@source}')"/>
  </fo:block>
  <fo:block text-align="center" font-weight="bold" space-after="12pt">Figure
    <xsl:number count="graphic" level="any"/> &#x2014;
    <xsl:value-of select="@title"/>
  </fo:block>
</xsl:template>

<xsl:attribute-set name="A4">
 <xsl:attribute name="page-width">210mm</xsl:attribute>
 <xsl:attribute name="page-height">297mm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="default">
  <xsl:attribute name="font-family">Helvetica</xsl:attribute>
  <xsl:attribute name="font-size">10pt</xsl:attribute>
  <xsl:attribute name="line-height">11.5pt</xsl:attribute>
  <xsl:attribute name="text-align">justify</xsl:attribute>
  <xsl:attribute name="language">en</xsl:attribute>
  <xsl:attribute name="country">US</xsl:attribute>
  <xsl:attribute name="orphans">2</xsl:attribute>
  <xsl:attribute name="widows">2</xsl:attribute>
  <xsl:attribute name="provisional-distance-between-starts">.71cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="para">
  <xsl:attribute name="space-after">12pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="Note" use-attribute-sets="para">
  <xsl:attribute name="font-size">9pt</xsl:attribute>
  <xsl:attribute name="line-height">10.5pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="STDTitle">
  <xsl:attribute name="text-align">left</xsl:attribute>
  <xsl:attribute name="font-size">16pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="line-height">17.5pt</xsl:attribute>
  <xsl:attribute name="space-before">20pt</xsl:attribute>
  <xsl:attribute name="space-after">38pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="Heading1">
  <xsl:attribute name="text-align">left</xsl:attribute>
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="line-height">13.5pt</xsl:attribute>
  <xsl:attribute name="space-before">13.5pt</xsl:attribute>
  <xsl:attribute name="space-after">12pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="Heading2" use-attribute-sets="Heading1">
  <xsl:attribute name="font-size">11pt</xsl:attribute>
  <xsl:attribute name="line-height">12.5pt</xsl:attribute>
  <xsl:attribute name="space-before">3pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="Heading3" use-attribute-sets="Heading1">
  <xsl:attribute name="font-size">10pt</xsl:attribute>
  <xsl:attribute name="line-height">11.5pt</xsl:attribute>
  <xsl:attribute name="space-before">3pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="ANNEX">
  <xsl:attribute name="text-align">center</xsl:attribute>
  <xsl:attribute name="font-size">14pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="line-height">15.5pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="VerticalMargins">
  <xsl:attribute name="margin-top">1.25cm</xsl:attribute>
  <xsl:attribute name="margin-bottom">.89cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="RightPageMargins" use-attribute-sets="VerticalMargins">
  <xsl:attribute name="margin-left">1.7cm</xsl:attribute>
  <xsl:attribute name="margin-right">1.3cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="LeftPageMargins" use-attribute-sets="VerticalMargins">
  <xsl:attribute name="margin-left">1.3cm</xsl:attribute>
  <xsl:attribute name="margin-right">1.7cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="BodyMargins">
  <xsl:attribute name="margin-top">48pt</xsl:attribute>
  <xsl:attribute name="margin-bottom">38pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="BodyFooterPageNumber">
  <xsl:attribute name="font-size">11pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="FrontFooterPageNumber">
  <xsl:attribute name="font-size">10pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="BodyHeader">
  <xsl:attribute name="font-size">11pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="BodyFirstPageHeader" use-attribute-sets="BodyHeader">
  <xsl:attribute name="font-size">11pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="line-height">11.5pt</xsl:attribute>
  <xsl:attribute name="padding-top">6pt</xsl:attribute>
  <xsl:attribute name="padding-bottom">6pt</xsl:attribute>
  <xsl:attribute name="border-top-style">solid</xsl:attribute>
  <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
  <xsl:attribute name="border-top-width">2.25pt</xsl:attribute>
  <xsl:attribute name="border-bottom-width">2.25pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="FooterCopyright">
  <xsl:attribute name="font-size">8pt</xsl:attribute>
</xsl:attribute-set>

<xsl:template match="/">
  <fo:root xsl:use-attribute-sets="default">
    <fo:layout-master-set>
      <fo:simple-page-master master-name="LeftPage" xsl:use-attribute-sets="A4 LeftPageMargins">
        <fo:region-before region-name="LeftPageHeader" extent="48pt"/>
        <fo:region-after region-name="LeftPageFooter" extent="14pt"/>
        <fo:region-body xsl:use-attribute-sets="BodyMargins"/>
      </fo:simple-page-master>
      <fo:simple-page-master master-name="RightPage" xsl:use-attribute-sets="A4 RightPageMargins">
        <fo:region-before region-name="RightPageHeader" extent="48pt"/>
        <fo:region-after region-name="RightPageFooter" extent="14pt"/>
        <fo:region-body xsl:use-attribute-sets="BodyMargins"/>
      </fo:simple-page-master>
      <fo:simple-page-master master-name="FrontFirstPage" xsl:use-attribute-sets="A4 RightPageMargins">
        <fo:region-before region-name="FirstPageHeader" extent="48pt"/>
        <fo:region-body xsl:use-attribute-sets="BodyMargins"/>
        <fo:region-after region-name="FirstPageFooter" extent="50pt"/>
      </fo:simple-page-master>
      <fo:simple-page-master master-name="BodyFirstPage" xsl:use-attribute-sets="A4 RightPageMargins">
        <fo:region-before region-name="FirstPageHeader" extent="48pt"/>
        <fo:region-after region-name="RightPageFooter" extent="14pt"/>
        <fo:region-body xsl:use-attribute-sets="BodyMargins"/>
      </fo:simple-page-master>
      <fo:page-sequence-master master-name="Front">
         <fo:repeatable-page-master-alternatives>
           <fo:conditional-page-master-reference master-reference="FrontFirstPage" page-position="first"/>
           <fo:conditional-page-master-reference master-reference="RightPage" odd-or-even="odd"/>
           <fo:conditional-page-master-reference master-reference="LeftPage" odd-or-even="even"/>
         </fo:repeatable-page-master-alternatives>
      </fo:page-sequence-master>
      <fo:page-sequence-master master-name="Body">
         <fo:repeatable-page-master-alternatives>
           <fo:conditional-page-master-reference master-reference="BodyFirstPage" page-position="first"/>
           <fo:conditional-page-master-reference master-reference="RightPage" odd-or-even="odd"/>
           <fo:conditional-page-master-reference master-reference="LeftPage" odd-or-even="even"/>
         </fo:repeatable-page-master-alternatives>
      </fo:page-sequence-master>
    </fo:layout-master-set>
    <fo:page-sequence master-reference="Front" format="i" initial-page-number="1">
      <fo:static-content flow-name="FirstPageHeader">
        <fo:block text-align="left">
           <xsl:call-template name="all-rights-reserved"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="FirstPageFooter">
        <fo:wrapper  white-space-collapse="false" text-align="left" line-height="11pt">
	  <fo:block>
  	    <xsl:text>Document type:  </xsl:text>
	    <xsl:value-of select="$head/document-type"/>
	  </fo:block>

	  <fo:block>
	  <xsl:text>Document subtype:</xsl:text>
	  </fo:block>

	  <fo:block>
	    <xsl:text>Document stage:   </xsl:text>
	    <xsl:choose>
	      <xsl:when test="$head/stage='preparatory'">(20) Preparatory</xsl:when>
	      <xsl:when test="$head/stage='committee'">(30) Committee</xsl:when>
	      <xsl:when test="$head/stage='committee-final'">(30) Committee</xsl:when>
	      <xsl:when test="$head/stage='enquiry'">(40) Enquiry</xsl:when>
	      <xsl:when test="$head/stage='approval'">(50) Approval</xsl:when>
	    </xsl:choose>
	  </fo:block>

	  <fo:block>
	    <xsl:text>Document language:   </xsl:text>
	    <xsl:value-of select="$head/document-language"/>
	  </fo:block>
        </fo:wrapper>
      </fo:static-content>
      <fo:static-content flow-name="LeftPageHeader">
        <fo:block xsl:use-attribute-sets="BodyHeader" text-align="left">
          <xsl:call-template name="document-number"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="RightPageHeader">
        <fo:block xsl:use-attribute-sets="BodyHeader" text-align="right">
          <xsl:call-template name="document-number"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="LeftPageFooter">
         <fo:list-block>
           <fo:list-item> <!--  relative-align="baseline" -->
             <fo:list-item-label>
                <fo:block xsl:use-attribute-sets="FrontFooterPageNumber" text-align="left">
                  <fo:page-number/>
                </fo:block>
             </fo:list-item-label>
             <fo:list-item-body>
                <fo:block xsl:use-attribute-sets="FooterCopyright" text-align="right">
                  <xsl:call-template name="all-rights-reserved"/>
                </fo:block>
             </fo:list-item-body>
           </fo:list-item>
         </fo:list-block> 
      </fo:static-content>
      <fo:static-content flow-name="RightPageFooter">
         <fo:list-block>
           <fo:list-item> <!--  relative-align="baseline" -->
             <fo:list-item-label>
                <fo:block xsl:use-attribute-sets="FrontFooterPageNumber" text-align="right">
                  <fo:page-number/>
                </fo:block>
             </fo:list-item-label>
             <fo:list-item-body>
                <fo:block xsl:use-attribute-sets="FooterCopyright" text-align="left">
                  <xsl:call-template name="all-rights-reserved"/>
                </fo:block>
             </fo:list-item-body>
           </fo:list-item>
         </fo:list-block> 
      </fo:static-content>
      <fo:flow flow-name="xsl-region-body">
        <xsl:apply-templates select="document/head"/>
        <xsl:apply-templates select="document" mode="toc"/>
        <xsl:apply-templates select="document/foreword"/>
        <xsl:apply-templates select="document/introduction"/>
      </fo:flow>
    </fo:page-sequence>
    <fo:page-sequence master-reference="Body" initial-page-number="1">
      <fo:static-content flow-name="LeftPageHeader">
        <fo:block xsl:use-attribute-sets="BodyHeader" text-align="left">
          <xsl:call-template name="document-number"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="FirstPageHeader">
         <fo:list-block xsl:use-attribute-sets="BodyFirstPageHeader">
           <fo:list-item> <!--  relative-align="baseline" -->
             <fo:list-item-label>
                <fo:block text-align="left">
                  <xsl:choose>
                    <xsl:when test="/document/head/stage='preparatory'">
                      <xsl:text>WORKING DRAFT</xsl:text>
                    </xsl:when>
                    <xsl:when test="/document/head/stage='committee'">
                      <xsl:text>COMMITTEE DRAFT</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:text>DRAFT INTERNATIONAL STANDARD</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </fo:block>
             </fo:list-item-label>
             <fo:list-item-body>
                <fo:block text-align="right">
                  <xsl:call-template name="document-number"/>
                </fo:block>
             </fo:list-item-body>
           </fo:list-item>
         </fo:list-block> 
      </fo:static-content>
      <fo:static-content flow-name="RightPageHeader">
        <fo:block xsl:use-attribute-sets="BodyHeader" text-align="right">
          <xsl:call-template name="document-number"/>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="LeftPageFooter">
         <fo:list-block>
           <fo:list-item> <!--  relative-align="baseline" -->
             <fo:list-item-label>
                <fo:block xsl:use-attribute-sets="BodyFooterPageNumber" text-align="left">
                  <fo:page-number/>
                </fo:block>
             </fo:list-item-label>
             <fo:list-item-body>
                <fo:block xsl:use-attribute-sets="FooterCopyright" text-align="right">
                  <xsl:call-template name="all-rights-reserved"/>
                </fo:block>
             </fo:list-item-body>
           </fo:list-item>
         </fo:list-block> 
      </fo:static-content>
      <fo:static-content flow-name="RightPageFooter">
         <fo:list-block>
           <fo:list-item> <!--  relative-align="baseline" -->
             <fo:list-item-label>
                <fo:block xsl:use-attribute-sets="BodyFooterPageNumber" text-align="right">
                  <fo:page-number/>
                </fo:block>
             </fo:list-item-label>
             <fo:list-item-body>
                <fo:block xsl:use-attribute-sets="FooterCopyright" text-align="left">
                  <xsl:call-template name="all-rights-reserved"/>
                </fo:block>
             </fo:list-item-body>
           </fo:list-item>
         </fo:list-block> 
      </fo:static-content>
      <fo:flow flow-name="xsl-region-body">
        <xsl:apply-templates select="document/*[not(self::foreword|self::introduction|self::head)]"/>
      </fo:flow>
    </fo:page-sequence>
  </fo:root>
</xsl:template>

<xsl:template name="all-rights-reserved">
   <xsl:text>© </xsl:text>
   <xsl:value-of select="$head/organization"/>
   <xsl:text> </xsl:text>
   <xsl:value-of select="substring-before($head/date, '-')"/>
   <xsl:text> &#8211; All rights reserved</xsl:text>
</xsl:template>

<xsl:template name="copyright-footer">
  <fo:wrapper font-size="8pt"><xsl:call-template name="all-rights-reserved"/></fo:wrapper>
</xsl:template>

<xsl:template match="document" mode="toc">
  <fo:list-block space-before="48pt" space-after="15.5pt" line-height="15.5pt" break-before="page">
    <fo:list-item> <!--  relative-align="baseline" -->
      <fo:list-item-label>
	 <fo:block font-size="14pt" font-weight="bold" text-align="left">
	   <xsl:text>Contents</xsl:text>
	 </fo:block>
      </fo:list-item-label>
      <fo:list-item-body>
	 <fo:block text-align="right">
	   <xsl:text>Page</xsl:text>
	 </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </fo:list-block>
  <fo:wrapper font-weight="bold">
    <xsl:apply-templates select="foreword" mode="toc"/>
    <xsl:apply-templates select="introduction" mode="toc"/>
    <xsl:apply-templates select="*[not(self::foreword|self::introduction|self::head)]" mode="toc"/>
  </fo:wrapper>
</xsl:template>

<xsl:attribute-set name="TOC">
</xsl:attribute-set>

<xsl:template match="foreword" mode="toc">
  <xsl:call-template name="toc">
    <xsl:with-param name="content">Foreword</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="introduction" mode="toc">
  <xsl:call-template name="toc">
    <xsl:with-param name="content">Introduction</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="bibliography" mode="toc">
  <xsl:call-template name="toc">
    <xsl:with-param name="content">Bibliography</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="scope" mode="toc">
  <xsl:call-template name="toc">
    <xsl:with-param name="content">Scope</xsl:with-param>
    <xsl:with-param name="number"><xsl:call-template name="clause-number"/></xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="normative-references" mode="toc">
  <xsl:call-template name="toc">
    <xsl:with-param name="content">Normative references</xsl:with-param>
    <xsl:with-param name="number"><xsl:call-template name="clause-number"/></xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="terms-and-definitions" mode="toc">
  <xsl:call-template name="toc">
    <xsl:with-param name="content">Terms and definitions</xsl:with-param>
    <xsl:with-param name="number"><xsl:call-template name="clause-number"/></xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="clause" mode="toc">
  <xsl:call-template name="toc">
    <xsl:with-param name="content"><xsl:apply-templates select="title"/></xsl:with-param>
    <xsl:with-param name="number"><xsl:call-template name="clause-number"/></xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="annex" mode="toc">
  <xsl:call-template name="toc">
    <xsl:with-param name="content">
      <xsl:text>Annex </xsl:text>
      <xsl:number count="annex" format="A"/>
      <fo:wrapper font-weight="normal">
	<xsl:text> (</xsl:text>
	<xsl:choose>
	  <xsl:when test="@normative='true'">normative</xsl:when>
	  <xsl:otherwise>informative</xsl:otherwise>
	</xsl:choose>
	<xsl:text>) </xsl:text>
      </fo:wrapper>
      <xsl:apply-templates select="title"/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="clause//clause|annex//clause" mode="toc">
  <xsl:call-template name="toc">
    <xsl:with-param name="content"><xsl:apply-templates select="title"/></xsl:with-param>
    <xsl:with-param name="number"><xsl:call-template name="clause-number"/></xsl:with-param>
    <xsl:with-param name="top" select="false()"/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="toc">
  <xsl:param name="content"/>
  <xsl:param name="number" select="''"/>
  <xsl:param name="top" select="true()"/>
  <xsl:choose>
    <xsl:when test="$number">
      <fo:list-block>
	<xsl:if test="$top">
	  <xsl:attribute name="space-before">6pt</xsl:attribute>
	</xsl:if>
	<fo:list-item>
	  <fo:list-item-label>
	    <fo:block text-align="left"><xsl:copy-of select="$number"/></fo:block>
	  </fo:list-item-label>
	  <fo:list-item-body start-indent="1.27cm">
	    <xsl:call-template name="toc-line">
	      <xsl:with-param name="content" select="$content"/>
	      <xsl:with-param name="top" select="false()"/>
	    </xsl:call-template>
	  </fo:list-item-body>
	</fo:list-item>
      </fo:list-block>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="toc-line">
	<xsl:with-param name="content" select="$content"/>
	<xsl:with-param name="top" select="$top"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:apply-templates select="clause" mode="toc"/>
</xsl:template>

<xsl:template name="toc-line">
  <xsl:param name="content"/>
  <xsl:param name="top" select="true()"/>
  <fo:block text-align-last="justify">
    <xsl:if test="$top">
      <xsl:attribute name="space-before">6pt</xsl:attribute>
    </xsl:if>
    <fo:basic-link internal-destination="{generate-id()}">
      <xsl:copy-of select="$content"/>
    </fo:basic-link>
    <fo:leader leader-pattern="dots"/>
    <xsl:text> </xsl:text>
    <fo:page-number-citation ref-id="{generate-id()}"/>
  </fo:block>
</xsl:template>

<xsl:template match="*" mode="toc"/>

</xsl:stylesheet>
