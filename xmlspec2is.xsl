<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
  version="2.0">

<xsl:template match="spec">
  <document>
    <head>
      <organization>ISO/IEC</organization>
      <document-type>International Standard</document-type>
      <stage>enquiry</stage>
      <tc-number>1</tc-number>
      <tc-name>Information Technology</tc-name>
      <sc-number>34</sc-number>
      <sc-name>Document Description and Processing Languages</sc-name>
      <wg-number>1</wg-number>
      <serial-number>0</serial-number>
      <document-number>19757</document-number>
      <part-number>11</part-number>
      <document-language>E</document-language>
      <secretariat>IPSJ/ITSCJ</secretariat>
      <date>2010-09-10</date>
      <!--
      <previous-date>2005-07-20</previous-date>
      <published-at>http://www.isotopicmaps.org/sam/sam-xtm/</published-at>
      -->
      <title>
        <introductory>Information Technology</introductory>
        <main>Document Schema Definition Languages (DSDL)</main>
        <complementary>Schema Association</complementary>
      </title>
      <editor>Jirka Kosek</editor>
    </head>
    
    <!-- ===== FOREWORD ========================================================-->
    <foreword>
      <p><This/> is being jointly developed by W3C and ISO/IEC JTC1/SC34. 
        The technical content of this specification and that of <xref to="xml-model"/> is expected to be identical.</p>
      <part-list>
        <part><number>1</number><title>Overview</title></part>
        <part><number>2</number><title>Grammar-based validation &#x2014; RELAX NG</title></part>
        <part><number>3</number><title>Rule-based validation &#x2014; Schematron</title></part>
        <part><number>4</number><title>Namespace-based validation dispatching language — NVDL</title></part>
        <part><number>5</number><title>Extensible Datatypes</title></part>
        <part><number>6</number><title>Path-based integrity constraints</title></part>
        <part><number>7</number><title>Character repertoire description language &#x2014; CREPDL</title></part>
        <part><number>8</number><title>Document schema renaming language &#x2014; DSRL</title></part>
        <part><number>9</number><title>Datatype- and namespace-aware DTDs</title></part>
        <part><number>10</number><title>Validation management</title></part>
        <part><number>11</number><title>Schema Association</title></part>
      </part-list>
    </foreword>
    
    <xsl:apply-templates/>
    
  </document>
</xsl:template>

<xsl:template match="div1[@id='introduction']">
  <introduction>
    <xsl:apply-templates/>
  </introduction>
  <scope>
    <xsl:apply-templates select="/spec/header/abstract/node()"/>
  </scope>
  <normative-references>
    <xsl:apply-templates select="/spec/back/div1[@id='references']/blist/bibl"/>
  </normative-references>
</xsl:template>

<xsl:template match="div1[@id='introduction']/head"/>
  
<xsl:template match="p">
  <p><xsl:apply-templates/></p>
</xsl:template>  

<xsl:template match="div1">
  <clause><xsl:apply-templates/></clause>
</xsl:template>  

<xsl:template match="inform-div1">
  <annex normative="false"><xsl:apply-templates/></annex>
</xsl:template>  
  

<xsl:template match="head">
  <title><xsl:apply-templates/></title>
</xsl:template>

<xsl:template match="p[rfc2119[../bibref[@ref='rfc2119']]]">
  <!-- Remove RFC lang para -->
</xsl:template>

<!-- must -> shall -->
<xsl:template match="text()">
  <xsl:value-of select="replace(
                          replace(., '-level', ''), 'must', 'shall')"/>
</xsl:template>
  
<xsl:template match="rfc2119[following-sibling::node()[1][self::text()][starts-with(., '-level')]]"/>  

<xsl:template match="bibref">
  <xref to="{@ref}"/>
</xsl:template>

<xsl:template match="bibl">
  <referenced-document id="{@id}">
    <xsl:if test="@key ne ''">
      <abbrev><xsl:value-of select="@key"/></abbrev>
    </xsl:if>
    <xsl:apply-templates mode="bibl"/>
    <xsl:if test="@href ne ''">
      <url><xsl:value-of select="@href"/></url>
    </xsl:if>
  </referenced-document>
  <xsl:if test="not(following-sibling::bibl)">
    <referenced-document id="xml-model">
      <abbrev>XML-MODEL</abbrev>
      <title>Associating Schemas with XML documents 1.0 (First Edition), </title>
      <field>P. Grosso, </field>
      <field>J. Kosek. </field>
      <field>W3C, April 2010.</field>
      <url>http://www.w3.org/TR/xml-model/</url>
    </referenced-document>
  </xsl:if>
</xsl:template>
  
<xsl:template match="titleref" mode="bibl">
  <title><xsl:apply-templates mode="bibl"/></title>
</xsl:template>

<xsl:template match="text()" mode="bibl">
  <field><xsl:value-of select="."/></field>
</xsl:template>
  
<xsl:template match="gitem">
  <constraint>
    <xsl:apply-templates/>
  </constraint>
</xsl:template>

<xsl:template match="gitem/label">
  <title>
    <xsl:apply-templates/>
  </title>
</xsl:template>
  
<xsl:template match="back/div1">
  <!-- Ignore list of references -->
</xsl:template>

<xsl:template match="code">
  <code><xsl:apply-templates/></code>
</xsl:template>

<xsl:template match="emph">
  <em><xsl:apply-templates/></em>
</xsl:template>
  
<xsl:template match="termdef|term">
  <xsl:copy><xsl:apply-templates/></xsl:copy>
</xsl:template>
  
<xsl:template match="xtermref">
  <i><xsl:apply-templates/></i>
</xsl:template>  
  
<xsl:template match="prodgroup">
  <prodlist><xsl:apply-templates/></prodlist>
</xsl:template>  

<xsl:template match="prod">
  <prod><xsl:apply-templates/></prod>
</xsl:template>  

<xsl:template match="lhs|rhs">
  <grp><xsl:apply-templates/></grp>
</xsl:template>  
  
<xsl:template match="xnt">
  <nt><xsl:apply-templates/></nt>
</xsl:template>  

<xsl:template match="olist">
  <ol><xsl:apply-templates/></ol>
</xsl:template>

<xsl:template match="olist/item">
  <li><xsl:apply-templates/></li>
</xsl:template>

<xsl:template match="example">
  <example><xsl:apply-templates/></example>
</xsl:template>

<xsl:template match="example/head">
  <p><i><xsl:apply-templates/></i></p>
</xsl:template>

<xsl:template match="eg">
  <pre><xsl:value-of select="replace(., '&#xA;&#xA;', '&#xA;')"/></pre>
</xsl:template>

<xsl:template match="table">
  <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="ednote|authlist|status|abstract|langusage|revisiondesc|scrap/head"/>

</xsl:stylesheet>
