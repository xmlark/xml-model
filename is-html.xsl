
<!--

 This XSLT stylesheet converts IS documents to HTML.
 Used for ISO 13250-2, -3, -4, 18048, and 19756

 $Id: is-html.xsl,v 1.1 2010/05/11 07:06:12 jkj Exp $

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:include href="is-common.xsl"/>

  <!-- Variables -->
  <xsl:param name="issuelinks">1</xsl:param>
  <xsl:variable name="head" select="/document/head"/>

  <!-- Keys -->
  <xsl:key name="id" match="clause|annex|referenced-document|li|
                            terms-and-definitions" use="@id"/>

  <!-- Main style rule -->

  <xsl:template match="document">
  <html>
  <head>
    <title><xsl:call-template name="document-title"/></title>
    <link rel="stylesheet" href="W3CNOTE.css" type="text/css"/>
  </head>

  <body>
  <xsl:call-template name="sc34-header"/>
  <h1><xsl:call-template name="document-title"/></h1>

  <h2><a name="toc">Contents</a></h2>
  <table>
  <tr><td>1</td> <td><a href="#scope">Scope</a></td></tr>
  <tr><td>2</td> <td><a href="#normative-references">Normative references</a></td></tr>
  <tr><td>3</td> <td><a href="#terms-and-definitions">Terms and definitions</a></td></tr>
    <xsl:apply-templates mode="toc"/>
  </table>

  <xsl:apply-templates/>
  </body>
  </html>
  </xsl:template>

  <!-- SC34 header -->

  <xsl:template name="sc34-header">
    <p align="right"><b><font size="+2"
      ><xsl:call-template name="committee"/>
       <xsl:if test="head / serial-number"
         >N<xsl:value-of select="head / serial-number"/></xsl:if></font></b></p>

    <P><A HREF="http://www.jtc1.org"><IMG SRC="images/isoiec.gif" WIDTH="130"
	  HEIGHT="56" ALT="ISO/IEC"/> </A></P>
    <H2><xsl:call-template name="committee"/></H2> 
    <H2><xsl:value-of select="head / tc-name"/> &#x2014;</H2> 
    <H2><xsl:value-of select="head / sc-name"/></H2>
    <TABLE> 
      <TR> 
        <th>Title: </th>
        <TD><xsl:call-template name="document-title"/></TD> 
      </TR> 
      <TR> 
        <th>Source:</th>
        <TD><xsl:choose>
	      <xsl:when test="head / author">
		<xsl:for-each select="head / author">
		  <xsl:value-of select="."/>
		  <xsl:if test="position() &lt; last()">, </xsl:if>
		</xsl:for-each>,
	      </xsl:when>
	      <xsl:otherwise>
		<xsl:for-each select="head / editor">
		  <xsl:value-of select="."/>
		  <xsl:if test="position() &lt; last()">, </xsl:if>
		</xsl:for-each>,
	      </xsl:otherwise>
	    </xsl:choose>
            JTC<xsl:value-of select="head / tc-number"/>
            / SC<xsl:value-of select="head / sc-number"/></TD> 
      </TR> 
      <TR> 
        <th>Project:</th>
        <TD>ISO <xsl:value-of select="$head / document-number"/>:
            <xsl:value-of select="$head / title / main"/></TD> 
      </TR> 
      <TR> 
        <th>Project editor:</th>
        <TD><xsl:for-each select="head / editor">
              <xsl:value-of select="."/>
              <xsl:if test="position() &lt; last()">, </xsl:if>
            </xsl:for-each></TD> 
      </TR> 
      <tr> 
        <th>Status:</th>
        <td><xsl:choose>
              <xsl:when test="head / stage = 'preparatory'">Working draft</xsl:when>
              <xsl:when test="head / stage = 'committee'">Committee draft</xsl:when>
              <xsl:when test="head / stage = 'committee-final'">Final Committee Draft</xsl:when>
              <xsl:when test="head / stage = 'approval'">Final Draft International Standard</xsl:when>
            </xsl:choose>
        </td>
      </tr> 
      <tr> 
        <th>Action:</th>
        <td>For review</td> 
      </tr> 
      <tr> 
        <th>Date:</th>
        <td><xsl:value-of select="head / date"/></td> 
      </tr> 
      <tr> 
        <th>Summary:</th>
        <td></td> 
      </tr> 
      <tr> 
        <th>Distribution:</th>
        <TD>SC34 and Liaisons</TD> 
      </tr> 
      <tr> 
        <th>Refer to:</th>
        <td>
          <xsl:if test="head / published-at">
            <xsl:variable name="url" select="head / published-at"/>
            <a href="{$url}{head / date}/">
              <xsl:value-of select="$url"/>
              <xsl:value-of select="head / date"/>
              <xsl:text>/</xsl:text>
            </a>
          </xsl:if>
        </td> 
      </tr> 
      <tr> 
        <th>Supercedes:</th>
        <td>
          <xsl:if test="head / published-at and head / previous-date">
            <xsl:variable name="url" select="head / published-at"/>
            <a href="{$url}{head / previous-date}/">
              <xsl:value-of select="$url"/>
              <xsl:value-of select="head / previous-date"/>
              <xsl:text>/</xsl:text>
            </a>
          </xsl:if>
        </td> 
      </tr> 
      <tr> 
        <th>Reply to:</th>
        <TD>Dr. James David Mason <BR/> (ISO/IEC JTC1/SC34 Chairman) <BR/> Y-12
      	 National Security Complex<BR/> Information Technology Services<BR/> Bldg. 9113
      	 M.S. 8208<BR/> Oak Ridge, TN 37831-8208 U.S.A.<BR/> Telephone: +1 865
      	 574-6973<BR/> Facsimile: +1 865 574-1896<BR/>E-mail:
      	 <A HREF="mailto:mxm@y12.doe.gov">mailto:mxm@y12.doe.gov</A><BR/><A
      	 HREF="http://www.y12.doe.gov/sgml/sc34/sc34oldhome.htm">http://www.y12.doe.gov/sgml/sc34/sc34oldhome.htm</A><BR/><BR/>

         Mr. G. Ken Holman<BR/>
         (ISO/IEC JTC 1/SC 34 Secretariat - Standards Council of Canada)<BR/> 
         Crane Softwrights Ltd.<BR/> Box 266,<BR/> Kars, ON K0A-2E0 CANADA<BR/>
	 Telephone: +1 613 489-0999<BR/> Facsimile: +1 613 489-0995<BR/> Network:
	 <A HREF="mailto:jtc1sc34@scc.ca">jtc1sc34@scc.ca</A></TD> 
      </tr> 
    </TABLE> 
  </xsl:template>

  <!-- Committee -->

  <xsl:template name="committee">
    <xsl:value-of select="head / organization"/>
      JTC<xsl:value-of select="head / tc-number"/>/SC<xsl:value-of select="head / sc-number"/>
  </xsl:template>

  <!-- Document title -->

  <xsl:template name="document-title">
    <xsl:value-of select="$head / title / main"/>

    <xsl:if test="$head / title / complementary">
      &#x2014; <xsl:value-of select="$head / title / complementary"/>
    </xsl:if>
  </xsl:template>

  <!-- Foreword -->

  <xsl:template match="foreword">
    <h2><a name="foreword">Foreword</a></h2>

    <p>ISO (the International Organization for Standardization) and
    IEC (the International Electrotechnical Commission) form the
    specialized system for worldwide standardization. National bodies
    that are members of ISO or IEC participate in the development of
    International Standards through technical committees established by
    the respective organization to deal with particular fields of
    technical activity. ISO and IEC technical committees collaborate in
    fields of mutual interest. Other international organizations,
    governmental and non-governmental, in liaison with ISO and IEC, also
    take part in the work. In the field of information technology, ISO and
    IEC have established a joint technical committee, ISO/IEC JTC 1.</p>

    <p>International Standards are drafted in accordance with the
    rules given in the ISO/IEC Directives, Part 2.</p>

    <p><xsl:value-of select="$head / organization"/> 
    <xsl:text> </xsl:text>
    <xsl:value-of select="$head / document-number"/>
    <xsl:if test="$head / part-number">
      <xsl:text>-</xsl:text> <xsl:value-of select="$head / part-number"/>
    </xsl:if>

    was prepared by Joint Technical Committee
    ISO/IEC JTC 1, Information Technology, Subcommittee SC 34, Document
    Description and Processing Languages.</p>

    <xsl:if test="part-list">
    <p><xsl:value-of select="$head / organization"/> 
    <xsl:text> </xsl:text>
    <xsl:value-of select="$head / document-number"/>
    consists of the following parts, under the
    general title <cite><xsl:value-of select="$head / title / main"/></cite>:</p>

    <ul>
    <xsl:for-each select="part-list / part">
      <li>Part <xsl:value-of select="number"/>: 
          <cite><xsl:value-of select="title"/></cite></li>
    </xsl:for-each>
    </ul>
    </xsl:if>
  </xsl:template>

  <!-- Introduction -->

  <xsl:template match="introduction">
    <h2><a name="introduction">Introduction</a></h2>

    <xsl:apply-templates/>
  </xsl:template>

  <!-- Scope -->

  <xsl:template match="scope">
    <h1><xsl:call-template name="document-title"/></h1>

    <h2>1 <a name="scope">Scope</a></h2>

    <xsl:apply-templates/>
  </xsl:template>

  <!-- Normative references -->

  <xsl:template match="normative-references">
    <h2>2 <a name="normative-references">Normative references</a></h2>

    <xsl:apply-templates/>

    <xsl:call-template name="verify-normative-references"/>
  </xsl:template>

  <xsl:template match="referenced-document">
    <p>
      <a>
	<xsl:attribute name="name">
	  <xsl:choose>
	    <xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
	    <xsl:otherwise><xsl:value-of select="generate-id(.)"/></xsl:otherwise>
	  </xsl:choose>
	</xsl:attribute>

	<xsl:for-each select="*">
	  <xsl:if test="not(position()=1)">, </xsl:if>
	  <xsl:apply-templates select="." mode="docrefs"/>
	</xsl:for-each>
      </a>
    </p>
  </xsl:template>

  <xsl:template match="title" mode="docrefs"><i><xsl:apply-templates/></i>
    </xsl:template>

  <xsl:template match="abbrev" mode="docrefs"><b><xsl:apply-templates/></b>
    </xsl:template>

  <xsl:template match="url" mode="docrefs"><a href="{.}"><xsl:apply-templates/></a>
    </xsl:template>

  <!-- Terms and definitions -->

  <xsl:template match="terms-and-definitions">
    <h2>3 <a name="terms-and-definitions">Terms and definitions</a></h2>

    <p>For the purposes of t<xsl:call-template name="his"/>, the following
    terms and definitions apply.</p>
    
    <xsl:apply-templates/>

    <xsl:for-each select="//termdef">
      <xsl:sort select="term"/>

      <h3>3.<xsl:number value="position()"/> <br/>
          <xsl:value-of select="term"/></h3>
  
      <p><xsl:apply-templates select="def"/></p>
    </xsl:for-each>
  </xsl:template>

  <!-- Clause -->

  <xsl:template match="document / clause">
    <h2><xsl:call-template name="clause-title"/></h2>

    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="document / clause / clause">
    <h3><xsl:call-template name="clause-title"/></h3>

    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="document / clause / clause / clause">
    <h4><xsl:call-template name="clause-title"/></h4>

    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template name="clause-title">
    <a><xsl:attribute name="name">
      <xsl:choose>
        <xsl:when test="@id">
          <xsl:value-of select="@id"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="generate-id(.)"/>
        </xsl:otherwise>
      </xsl:choose></xsl:attribute>
     <xsl:number count="clause | scope | terms-and-definitions | normative-references"
                    format="1 " level="multiple"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="title"/></a>
  </xsl:template>


  <xsl:template match="annex">
    <h2><a><xsl:attribute name="name">
      <xsl:choose>
        <xsl:when test="@id">
          <xsl:value-of select="@id"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="generate-id(.)"/>
        </xsl:otherwise>
      </xsl:choose></xsl:attribute>
     <xsl:number count="annex" format="A " level="multiple"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="title"/>

       <xsl:choose>
         <xsl:when test="@normative = 'false'"> (informative)</xsl:when>
         <xsl:otherwise> (normative)</xsl:otherwise>
       </xsl:choose>
     </a></h2>

    <xsl:apply-templates/>
  </xsl:template>

  <!-- Bibliography -->

  <xsl:template match="bibliography">
    <h2><a name="bibliography">Bibliography</a></h2>

    <xsl:apply-templates/>
  </xsl:template>

  <!-- Ignore -->

  <xsl:template match="body | field | termdef | def"
    ><xsl:apply-templates/></xsl:template>

  <!-- Leave out -->

  <xsl:template match="title | head"/>

  <!-- Blocks -->

  <xsl:template match="p">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="ol">
    <ol>
      <xsl:apply-templates/>
    </ol>
  </xsl:template>

  <xsl:template match="ul">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>

  <xsl:template match="li">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <xsl:template match="dl">
    <dl><xsl:apply-templates/></dl>
  </xsl:template>

  <xsl:template match="dt">
    <dt><xsl:apply-templates/></dt>
  </xsl:template>

  <xsl:template match="dd">
    <dd><xsl:apply-templates/></dd>
  </xsl:template>

  <xsl:template match="note">
    <div class="note"><b>NOTE:</b> <xsl:apply-templates/></div>
  </xsl:template>

  <xsl:template match="example">
    <div class="note"><b>EXAMPLE:</b> <xsl:apply-templates/></div>
  </xsl:template>

  <xsl:template match="ednote">
    <div class="ednote">
      <b>Ed. Note:</b>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="issue">
    <div class="issue">
      <p class="prefix">
	<xsl:choose>
          <xsl:when test="@id and $issuelinks">
  	    <a name="{@id}" href="http://www.ontopia.net/omnigator/models/topic_complete.jsp?tm=tm-standards.xtm&amp;id={@id}">
  	    <b><xsl:text>Issue (</xsl:text><xsl:value-of select="@id"/><xsl:text>):</xsl:text></b>
            </a>
          </xsl:when>
          <xsl:otherwise>
  	    <b><xsl:text>Issue (</xsl:text><xsl:value-of select="@id"/><xsl:text>):</xsl:text></b>
          </xsl:otherwise>
	</xsl:choose>
      </p>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="issue/head">
    <p class="prefix">
      <b><xsl:apply-templates/></b>
    </p>
  </xsl:template>

  <xsl:template match="constraint">
    <div class="constraint">
    <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="constraint/title">
    <p class="prefix">
      <xsl:if test="../@id">
	<a name="{../@id}"/>
      </xsl:if>
      <b><xsl:value-of select="../@type"/>
         <xsl:text> Constraint: </xsl:text><xsl:apply-templates/></b>
    </p>
  </xsl:template>

  <xsl:template match="graphic">
    <img src="{@source}">
      <xsl:if test="@alt">
        <xsl:attribute name="alt">
          <xsl:value-of select="@alt"/>
        </xsl:attribute>
      </xsl:if>
    </img>
    <p class="caption">Figure <xsl:number count="graphic" level="any"/> &#x2014; 
      <xsl:value-of select="@title"/></p>
  </xsl:template>

  <xsl:template match="pre">
    <table class="eg" width="100%"><tr><td>
      <pre><xsl:apply-templates/></pre>
    </td></tr></table>
  </xsl:template>

  <!-- Published subjects -->
  <xsl:template match="published-subjects">
    <xsl:variable name="prefix" select="@prefix"/>

    <!-- render -->
    <dl>
    <xsl:for-each select="//termdef">
      <xsl:sort select="term"/>

      <xsl:variable name="name" select='translate(normalize-space(term), " ", "-")'/>

      <dt><xsl:value-of select="term"/></dt>
      <dd><xsl:value-of select="$prefix"/><xsl:value-of select="$name"/></dd>
      </xsl:for-each>
    </dl>
  </xsl:template>

  <!-- Inline -->

  <xsl:template match="term"><b><xsl:apply-templates/></b></xsl:template>
  <xsl:template match="em"><em><xsl:apply-templates/></em></xsl:template>
  <xsl:template match="code"><code><xsl:apply-templates/></code></xsl:template>
  <xsl:template match="el"><tt><xsl:apply-templates/></tt></xsl:template>
  <xsl:template match="att"><tt><xsl:apply-templates/></tt></xsl:template>
  <xsl:template match="b"><b><xsl:apply-templates/></b></xsl:template>
  <xsl:template match="i"><i><xsl:apply-templates/></i></xsl:template>
  <xsl:template match="var"><i><xsl:apply-templates/></i></xsl:template>

  <!-- Cross-references -->

  <xsl:template match="xref">
    <xsl:variable name="target" select="key('id', @to)"/>
    <xsl:apply-templates select="$target" mode="xref"/>

    <xsl:if test="count($target) = 0">
      <xsl:message terminate="no">ERROR: Bad reference '<xsl:value-of select="@to"/>'</xsl:message>
      <b><font color="red">ERROR: Bad reference '<xsl:value-of select="@to"/>'</font></b>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="Xref">
    <xsl:apply-templates select="key('id',@to)" mode="Xref"/>
  </xsl:template>
  
  <xsl:template match="*" mode="Xref">
    <xsl:apply-templates mode="xref" select="."/>
  </xsl:template>
  
  <xsl:template match="clause//clause|annex//clause" mode="xref">
    <a>
      <xsl:call-template name="make-reference"/>
      <xsl:call-template name="clause-number"/>
    </a>
  </xsl:template>

  <xsl:template match="clause" mode="xref">
    <a>
      <xsl:call-template name="make-reference"/>

      <xsl:text>Clause </xsl:text>
      <xsl:call-template name="clause-number"/>
    </a>
  </xsl:template>
  
  <xsl:template match="annex" mode="xref">
    <a>
      <xsl:call-template name="make-reference"/>
      <xsl:text>Annex </xsl:text>
      <xsl:number format="A"/>
    </a>
  </xsl:template>
  
  <xsl:template match="referenced-document" mode="xref">
    <i><xsl:text>[</xsl:text><a>
      <xsl:call-template name="make-reference"/>
      <xsl:value-of select="abbrev"/>
    </a><xsl:text>]</xsl:text></i>
  </xsl:template>

  <xsl:template match="terms-and-definitions" mode="xref">
    <a>
      <xsl:call-template name="make-reference"/>
      <xsl:text>Clause 3</xsl:text> <!-- it's always #3 -->
    </a>
  </xsl:template>

  <!-- ToC mode -->
  <xsl:template match="head | introduction | foreword | bibliography |
                       scope | normative-references | terms-and-definitions" 
                mode="toc"/>

  <xsl:template match="clause" mode="toc">
    <tr><td>
    <xsl:number count="clause | scope | terms-and-definitions | normative-references"
                    format="1 " level="multiple"/>&#160;</td>

    <td><a><xsl:attribute name="href">
        <xsl:choose>
          <xsl:when test="@id">
            <xsl:text>#</xsl:text><xsl:value-of select="@id"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>#</xsl:text><xsl:value-of select="generate-id(.)"/>
          </xsl:otherwise>
        </xsl:choose></xsl:attribute>
        <xsl:value-of select="title"/></a></td></tr>

    <xsl:apply-templates select="clause" mode="toc"/>
  </xsl:template>

  <xsl:template match="annex" mode="toc">
    <tr><td>
    <xsl:number count="annex"
                    format="A " level="multiple"/>&#160;</td>

    <td><a><xsl:attribute name="href">
        <xsl:choose>
          <xsl:when test="@id">
            <xsl:text>#</xsl:text><xsl:value-of select="@id"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>#</xsl:text><xsl:value-of select="generate-id(.)"/>
          </xsl:otherwise>
        </xsl:choose></xsl:attribute>
        <xsl:value-of select="title"/></a></td></tr>

    <xsl:apply-templates select="clause" mode="toc"/>
  </xsl:template>

  <!-- Named templates -->

  <xsl:template name="make-reference">
    <xsl:attribute name="href">
      <xsl:choose>
	<xsl:when test="@id">#<xsl:value-of select="@id"/></xsl:when>
	<xsl:otherwise>#<xsl:value-of select="generate-id()"/></xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>    
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
  
  <!-- Fallback template -->

  <xsl:template match="*">
  <font color="blue">[<xsl:value-of select="local-name(current())"/>: <xsl:apply-templates/>]</font>
  </xsl:template>

</xsl:stylesheet>
