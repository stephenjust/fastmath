<?xml version='1.0' encoding="UTF-8"?>
<xsl:stylesheet
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:m="http://www.w3.org/1998/Math/MathML"
		version='1.0'>
                
<!-- ====================================================================== -->
<!-- $id: tokens.xsl, 2002/22/11 Exp $
     This file is part of the XSLT MathML Library distribution.
     See ./README or http://www.raleigh.ru/MathML/mmltex for
     copyright and other information                                        -->
<!-- ====================================================================== -->

<!-- 4.4.1.1 cn -->
<xsl:template match="cn"><xsl:apply-templates/></xsl:template>

<xsl:template match="cn[@type='complex-cartesian']">
	<xsl:apply-templates select="text()[1]"/>
  	<xsl:text>+</xsl:text>
	<xsl:apply-templates select="text()[2]"/>
	<xsl:text>i</xsl:text>
</xsl:template>

<xsl:template match="cn[@type='rational']">
	<xsl:apply-templates select="text()[1]"/>
	<xsl:text>/</xsl:text>
	<xsl:apply-templates select="text()[2]"/>
</xsl:template>

<xsl:template match="cn[@type='integer' and @base!=10]">
		<xsl:apply-templates/>
		<xsl:text>_{</xsl:text><xsl:value-of select="@base"/><xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="cn[@type='complex-polar']">
	<xsl:apply-templates select="text()[1]"/>
	<xsl:text>e^{i </xsl:text>
	<xsl:apply-templates select="text()[2]"/>
	<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="cn[@type='e-notation']">
    <xsl:apply-templates select="text()[1]"/>
    <xsl:text>E</xsl:text>
    <xsl:apply-templates select="text()[2]"/>
</xsl:template>

<!-- 4.4.1.1 ci 4.4.1.2 csymbol -->
<xsl:template match="ci | csymbol">
	<xsl:choose>
		<xsl:when test="string-length(normalize-space(text()))>1">
			<xsl:text>\mathrm{</xsl:text><xsl:apply-templates/><xsl:text>}</xsl:text>
		</xsl:when>
		<xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- 4.4.2.1 apply 4.4.2.2 reln -->
<xsl:template match="apply | reln">
	<xsl:apply-templates select="*[1]">
	<!-- <? -->
		<xsl:with-param name="p" select="10"/>
	</xsl:apply-templates>
	<!-- ?> -->
 	<xsl:text>(</xsl:text>
	<xsl:for-each select="*[position()>1]">
		<xsl:apply-templates select="."/>
		<xsl:if test="not(position()=last())"><xsl:text>, </xsl:text></xsl:if>
	</xsl:for-each>
 	<xsl:text>)</xsl:text>
</xsl:template>

<!-- 4.4.2.3 fn -->
<xsl:template match="fn[apply[1]]"> <!-- for fn using default rule -->
	<xsl:text>(</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
</xsl:template>

<!-- 4.4.2.4 interval -->
<xsl:template match="interval[*[2]]">
	<xsl:choose>
		<xsl:when test="@closure='open' or @closure='open-closed'">
			<xsl:text>(</xsl:text>		
		</xsl:when>
		<xsl:otherwise><xsl:text>[</xsl:text></xsl:otherwise> 
	</xsl:choose>
	<xsl:apply-templates select="*[1]"/>
	<xsl:text> , </xsl:text>
	<xsl:apply-templates select="*[2]"/>
	<xsl:choose>
		<xsl:when test="@closure='open' or @closure='closed-open'">
			<xsl:text>)</xsl:text>		
		</xsl:when>
		<xsl:otherwise><xsl:text>]</xsl:text></xsl:otherwise> 
	</xsl:choose>
</xsl:template>

<xsl:template match="interval">
	<xsl:text>\left\{</xsl:text><xsl:apply-templates/><xsl:text>\right\}</xsl:text>
</xsl:template>

<!-- 4.4.2.5 inverse -->
<xsl:template match="apply[*[1][self::inverse]]">
	<xsl:apply-templates select="*[2]"/><xsl:text>^{(-1)}</xsl:text>
</xsl:template>

<!-- 4.4.2.6 sep 4.4.2.7 condition -->
<xsl:template match="sep | condition"><xsl:apply-templates/></xsl:template>

<!-- 4.4.2.9 lambda -->
<xsl:template match="lambda">
	<xsl:text>\mathrm{lambda}\: </xsl:text>
  	<xsl:apply-templates select="bvar/*"/>
  	<xsl:text>.\: </xsl:text>
  <xsl:apply-templates select="*[last()]"/>
</xsl:template>

<!-- 4.4.2.10 compose -->
<xsl:template match="apply[*[1][self::compose]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="1"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\circ </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.2.11 ident -->
<xsl:template match="ident"><xsl:text>\mathrm{id}</xsl:text></xsl:template>

<!-- 4.4.2.12 domain 4.4.2.13 codomain 4.4.2.14 image 4.4.3.21 arg 4.4.3.24 lcm
		4.4.5.9 grad 4.4.5.10 curl 4.4.9.4 median 4.4.9.5 mode-->
<xsl:template match="domain | codomain | image | arg | lcm | grad |
								 curl | median | mode">
	<xsl:text></xsl:text>
	<xsl:value-of select="local-name()"/>
	<xsl:text></xsl:text>
</xsl:template>

<!-- 4.4.2.15 domainofapplication -->
<xsl:template match="domainofapplication"/>

<!-- 4.4.2.16 piecewise -->
<xsl:template match="piecewise">
	<xsl:text>\begin{cases}</xsl:text>
	<xsl:apply-templates select="piece"/>
	<xsl:apply-templates select="otherwise"/>
	<xsl:text>\end{cases}</xsl:text>
</xsl:template>

<xsl:template match="piece">
		<xsl:apply-templates select="*[1]"/>
		<xsl:text> &amp; \text{if $</xsl:text>
		<xsl:apply-templates select="*[2]"/>
		<xsl:text>$}</xsl:text>
		<xsl:if test="not(position()=last()) or ../otherwise"><xsl:text>\\ </xsl:text></xsl:if>
</xsl:template>

<xsl:template match="otherwise">
	<xsl:apply-templates select="*[1]"/>
	<xsl:text> &amp; \text{otherwise}</xsl:text>
</xsl:template>

<!-- 4.4.3.1 quotient -->
<xsl:template match="apply[*[1][self::quotient]]">
	<xsl:text>(</xsl:text>
	<xsl:apply-templates select="*[2]"/>
	<xsl:text>) / (</xsl:text>
	<xsl:apply-templates select="*[3]"/>
	<xsl:text>)</xsl:text>
</xsl:template>

<!-- 4.4.3.2 factorial -->
<xsl:template match="apply[*[1][self::factorial]]">
	<xsl:apply-templates select="*[2]">
		<xsl:with-param name="p" select="7"/>
	</xsl:apply-templates>
	<xsl:text>!</xsl:text>
</xsl:template>

<!-- 4.4.3.3 divide -->
<xsl:template match="apply[*[1][self::divide]]">
	<xsl:param name="p" select="0"/>
  <xsl:param name="this-p" select="3"/>
  <xsl:if test="$this-p &lt; $p"><xsl:text>(</xsl:text></xsl:if>
  <xsl:text>(</xsl:text>
	<xsl:apply-templates select="*[2]"/>
<!--		<xsl:with-param name="p" select="$this-p"/>
	</xsl:apply-templates>-->
	<xsl:text>) / (</xsl:text>
	<xsl:apply-templates select="*[3]"/>
<!--    	<xsl:with-param name="p" select="$this-p"/>
	</xsl:apply-templates>-->
	<xsl:text>)</xsl:text>
	<xsl:if test="$this-p &lt; $p"><xsl:text>)</xsl:text></xsl:if>
</xsl:template>

<!-- 4.4.3.4 max min -->
<xsl:template match="apply[*[1][self::max or self::min]]">
	<xsl:text>\</xsl:text>
	<xsl:value-of select="local-name(*[1])"/>
	<xsl:text>\{</xsl:text>
   <xsl:choose>
		<xsl:when test="condition">
   		<xsl:apply-templates select="*[last()]"/>
   		<xsl:text>, </xsl:text>
			<xsl:apply-templates select="condition/node()"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="*[position() &gt; 1]">
				<xsl:apply-templates select="."/>
				<xsl:if test="position() !=last()"><xsl:text> , </xsl:text></xsl:if>
			</xsl:for-each>
		</xsl:otherwise>
   </xsl:choose>
	<xsl:text>\}</xsl:text>
</xsl:template>

<!-- 4.4.3.5  minus-->
<xsl:template match="apply[*[1][self::minus] and count(*)=2]">
	<xsl:text>-</xsl:text>
	<xsl:apply-templates select="*[2]">
		<xsl:with-param name="p" select="5"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="apply[*[1][self::minus] and count(*)&gt;2]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="binary">
		<xsl:with-param name="mo">-</xsl:with-param>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="this-p" select="2"/>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.3.6  plus-->
<xsl:template match="apply[*[1][self::plus]]">
  <xsl:param name="p" select="0"/>
  <xsl:if test="$p &gt; 2">
		<xsl:text>(</xsl:text>
	</xsl:if>
  <xsl:for-each select="*[position()&gt;1]">
   <xsl:if test="position() &gt; 1">
    <xsl:choose>
      <xsl:when test="self::apply[*[1][self::times] and
      *[2][self::apply/*[1][self::minus] or self::cn[not(sep) and
      (number(.) &lt; 0)]]]">-</xsl:when>
      <xsl:otherwise>+</xsl:otherwise>
    </xsl:choose>
   </xsl:if>   
    <xsl:choose>
      <xsl:when test="self::apply[*[1][self::times] and
      *[2][self::cn[not(sep) and (number(.) &lt;0)]]]">
			<xsl:value-of select="-(*[2])"/>
			<xsl:apply-templates select=".">
		     <xsl:with-param name="first" select="2"/>
		     <xsl:with-param name="p" select="2"/>
		   </xsl:apply-templates>
       </xsl:when>
      <xsl:when test="self::apply[*[1][self::times] and
      *[2][self::apply/*[1][self::minus]]]">
				<xsl:apply-templates select="./*[2]/*[2]"/>
				<xsl:apply-templates select=".">
					<xsl:with-param name="first" select="2"/>
					<xsl:with-param name="p" select="2"/>
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select=".">
					<xsl:with-param name="p" select="2"/>
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:if test="$p &gt; 2">
		<xsl:text>)</xsl:text>
	</xsl:if>
</xsl:template>

<!-- 4.4.3.7 power -->
<xsl:template match="apply[*[1][self::power]]">
	<xsl:apply-templates select="*[2]">
		<xsl:with-param name="p" select="5"/>
	</xsl:apply-templates>
	<xsl:text>^{</xsl:text>
	<xsl:apply-templates select="*[3]">
		<xsl:with-param name="p" select="5"/>
	</xsl:apply-templates>
	<xsl:text>}</xsl:text>
</xsl:template>

<!-- 4.4.3.8 remainder -->
<xsl:template match="apply[*[1][self::rem]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="binary">
		<xsl:with-param name="mo">\mod </xsl:with-param>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="this-p" select="3"/>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.3.9  times-->
<xsl:template match="apply[*[1][self::times]]" name="times">
  <xsl:param name="p" select="0"/>
  <xsl:param name="first" select="1"/>
  <xsl:if test="$p &gt; 3"><xsl:text>(</xsl:text></xsl:if>
  <xsl:for-each select="*[position()&gt;1]">
		<xsl:if test="position() &gt; 1">
			<xsl:choose>
				<xsl:when test="self::cn">\times <!-- times --></xsl:when>
				<xsl:otherwise><!--invisible times--></xsl:otherwise>
			</xsl:choose>
		</xsl:if> 
		<xsl:if test="position()&gt;= $first">
			<xsl:apply-templates select=".">
				<xsl:with-param name="p" select="3"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:for-each>
  <xsl:if test="$p &gt; 3"><xsl:text>)</xsl:text></xsl:if>
</xsl:template>

<!-- 4.4.3.10 root -->
<xsl:template match="apply[*[1][self::root]]">
	<xsl:text>\sqrt</xsl:text>
	<xsl:if test="degree!=2">
		<xsl:text>[</xsl:text>
		<xsl:apply-templates select="degree/*"/>
		<xsl:text>]</xsl:text>
	</xsl:if>
	<xsl:text>{</xsl:text>
	<xsl:apply-templates select="*[position()&gt;1 and not(self::degree)]"/>
	<xsl:text>}</xsl:text>
</xsl:template>

<!-- 4.4.3.11 gcd -->
<xsl:template match="gcd"><xsl:text>\gcd </xsl:text></xsl:template>

<!-- 4.4.3.12 and -->
<xsl:template match="apply[*[1][self::and]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="2"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\land <!-- and --></xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.3.13 or -->
<xsl:template match="apply[*[1][self::or]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="3"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\lor </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.3.14 xor -->
<xsl:template match="apply[*[1][self::xor]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="3"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\mathop{\mathrm{xor}}</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.3.15 not -->
<xsl:template match="apply[*[1][self::not]]">
	<xsl:text>\neg </xsl:text>
	<xsl:apply-templates select="*[2]">
		<xsl:with-param name="p" select="7"/>
	</xsl:apply-templates>
</xsl:template>

<!-- 4.4.3.16 implies -->
<xsl:template match="apply[*[1][self::implies]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="binary">
		<xsl:with-param name="mo">\implies </xsl:with-param>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="this-p" select="3"/>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.3.17 forall 4.4.3.18 exists -->
<xsl:template match="apply[*[1][self::forall or self::exists]]">
	<xsl:text>\</xsl:text>
	<xsl:value-of select="local-name(*[1])"/>
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="bvar"/>
	<xsl:if test="condition">
		<xsl:text>, </xsl:text><xsl:apply-templates select="condition"/>
	</xsl:if>
	<xsl:if test="*[last()][local-name()!='condition'][local-name()!='bvar']">
		<xsl:text>\colon </xsl:text>
	  <xsl:apply-templates select="*[last()]"/>
  </xsl:if>
</xsl:template>

<!-- 4.4.3.19 abs -->
<xsl:template match="apply[*[1][self::abs]]">
	<xsl:text>Abs(</xsl:text>
	<xsl:apply-templates select="*[2]"/>
	<xsl:text>)</xsl:text>
</xsl:template>

<!-- 4.4.3.20 conjugate -->
<xsl:template match="apply[*[1][self::conjugate]]">
	<xsl:text>\overline{</xsl:text><xsl:apply-templates select="*[2]"/><xsl:text>}</xsl:text>
</xsl:template>

<!-- 4.4.3.22 real -->
<xsl:template match="real"><xsl:text>\Re </xsl:text></xsl:template>

<!-- 4.4.3.23 imaginary -->
<xsl:template match="imaginary"><xsl:text>\Im </xsl:text></xsl:template>

<!-- 4.4.3.25 floor -->
<xsl:template match="apply[*[1][self::floor]]">
	<xsl:text>\lfloor </xsl:text>
	<xsl:apply-templates select="*[2]"/>
	<xsl:text>\rfloor </xsl:text>
</xsl:template>

<!-- 4.4.3.25 ceiling -->
<xsl:template match="apply[*[1][self::ceiling]]">
	<xsl:text>\lceil </xsl:text>
	<xsl:apply-templates select="*[2]"/>
	<xsl:text>\rceil </xsl:text>
</xsl:template>

<!-- 4.4.4.1 eq -->
<xsl:template match="apply[*[1][self::eq]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="1"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">=</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.4.2 neq -->
<xsl:template match="apply[*[1][self::neq]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="1"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\neq </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.4.3 gt -->
<xsl:template match="apply[*[1][self::gt]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
	<xsl:with-param name="this-p" select="1"/>
	<xsl:with-param name="p" select="$p"/>
	<xsl:with-param name="mo">&gt; </xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.4.4 lt -->
<xsl:template match="apply[*[1][self::lt]]">
<xsl:param name="p" select="0"/>
<xsl:call-template name="infix">
	<xsl:with-param name="this-p" select="1"/>
	<xsl:with-param name="p" select="$p"/>
	<xsl:with-param name="mo">&lt; </xsl:with-param>
</xsl:call-template>
</xsl:template>

<!-- 4.4.4.5 geq -->
<xsl:template match="apply[*[1][self::geq]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="1"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\ge </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.4.6 leq -->
<xsl:template match="apply[*[1][self::leq]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="1"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\le </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.4.7 equivalent -->
<xsl:template match="apply[*[1][self::equivalent]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="1"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\equiv </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.4.8 approx -->
<xsl:template match="apply[*[1][self::approx]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="1"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\approx </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.4.9 factorof -->
<xsl:template match="apply[*[1][self::factorof]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="binary">
		<xsl:with-param name="mo"> | </xsl:with-param>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="this-p" select="3"/>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.5.1 int -->
<xsl:template match="apply[*[1][self::int]]">
	<xsl:text>\int</xsl:text>
	<xsl:if test="lowlimit/*|interval/*[1]|condition/*">
		<xsl:text>_{</xsl:text>
		<xsl:apply-templates select="lowlimit/*|interval/*[1]|condition/*"/>
		<xsl:text>}</xsl:text>
	</xsl:if>
	<xsl:if test="uplimit/*|interval/*[2]">
		<xsl:text>^{</xsl:text>
		<xsl:apply-templates select="uplimit/*|interval/*[2]"/>
		<xsl:text>}</xsl:text>
	</xsl:if>
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="*[last()]"/>
	<xsl:text>\,d </xsl:text>
	<xsl:apply-templates select="bvar"/>
</xsl:template>

<!-- 4.4.5.2 diff -->
<xsl:template match="apply[*[1][self::diff] and ci and count(*)=2]" priority="2">
	<xsl:apply-templates select="*[2]"/>
	<xsl:text>^\prime </xsl:text>
</xsl:template>

<xsl:template match="apply[*[1][self::diff]]" priority="1">
	<xsl:text>\frac{</xsl:text>
	<xsl:choose>
		<xsl:when test="bvar/degree">
			<xsl:text>d^{</xsl:text>
			<xsl:apply-templates select="bvar/degree/node()"/>
			<xsl:text>}</xsl:text>
			<xsl:apply-templates select="*[last()]"/>
			<xsl:text>}{d</xsl:text>
			<xsl:apply-templates select="bvar/node()"/>
			<xsl:text>^{</xsl:text>
			<xsl:apply-templates select="bvar/degree/node()"/>
			<xsl:text>}</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>d </xsl:text>
			<xsl:apply-templates select="*[last()]"/>
			<xsl:text>}{d </xsl:text>
			<xsl:apply-templates select="bvar"/>
			<xsl:text>}</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:text>}</xsl:text>
</xsl:template>

<!-- 4.4.5.3 partialdiff -->
<xsl:template match="apply[*[1][self::partialdiff] and list and ci and count(*)=3]" priority="2">
	<xsl:text>D_{</xsl:text>
	<xsl:for-each select="list[1]/*">
		<xsl:apply-templates select="."/>
		<xsl:if test="position()&lt;last()"><xsl:text>, </xsl:text></xsl:if>
	</xsl:for-each>
	<xsl:text>}</xsl:text>
	<xsl:apply-templates select="*[3]"/>
</xsl:template>

<xsl:template match="apply[*[1][self::partialdiff]]" priority="1">
	<xsl:text>\frac{\partial^{</xsl:text>
	<xsl:choose>
		<xsl:when test="degree">
			<xsl:apply-templates select="degree/node()"/>
		</xsl:when>
		<xsl:when test="bvar/degree[string(number(.))='NaN']">
			<xsl:for-each select="bvar/degree">
				<xsl:apply-templates select="node()"/>
				<xsl:if test="position()&lt;last()"><xsl:text>+</xsl:text></xsl:if>
			</xsl:for-each>
			<xsl:if test="count(bvar[not(degree)])&gt;0">
				<xsl:text>+</xsl:text>
				<xsl:value-of select="count(bvar[not(degree)])"/>
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="sum(bvar/degree)+count(bvar[not(degree)])"/>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:text>}</xsl:text>
	<xsl:apply-templates select="*[last()]"/>
	<xsl:text>}{</xsl:text>
	<xsl:for-each select="bvar">
		<xsl:text>\partial </xsl:text>
		<xsl:apply-templates select="node()"/>
		<xsl:if test="degree">
			<xsl:text>^{</xsl:text>
			<xsl:apply-templates select="degree/node()"/>
			<xsl:text>}</xsl:text>
		</xsl:if>
	</xsl:for-each>
	<xsl:text>}</xsl:text>
</xsl:template>

<!-- 4.4.2.8 declare 4.4.5.4 lowlimit 4.4.5.5 uplimit 4.4.5.7 degree 4.4.9.5 momentabout -->
<xsl:template match="declare | lowlimit | uplimit | degree | momentabout"/>

<!-- 4.4.5.6  bvar-->
<xsl:template match="bvar">
	<xsl:apply-templates/>
	<xsl:if test="following-sibling::bvar"><xsl:text>, </xsl:text></xsl:if>
</xsl:template>

<!-- 4.4.5.8 divergence-->
<xsl:template match="divergence"><xsl:text>\mathop{\mathrm{div}}</xsl:text></xsl:template>

<!-- 4.4.5.11 laplacian-->
<xsl:template match="laplacian"><xsl:text>\nabla^2 </xsl:text></xsl:template>

<!-- 4.4.6.1 set -->
<xsl:template match="set">
	<xsl:text>\{</xsl:text><xsl:call-template name="set"/><xsl:text>\}</xsl:text>
</xsl:template>

<!-- 4.4.6.2 list -->
<xsl:template match="list">
	<xsl:text>\left[</xsl:text><xsl:call-template name="set"/><xsl:text>\right]</xsl:text>
</xsl:template>

<xsl:template name="set">
   <xsl:choose>
		<xsl:when test="condition">
   		<xsl:apply-templates select="bvar/*[not(self::bvar or self::condition)]"/>
   		<xsl:text>\colon </xsl:text>
			<xsl:apply-templates select="condition/node()"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:for-each select="*">
				<xsl:apply-templates select="."/>
				<xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
			</xsl:for-each>
		</xsl:otherwise>
   </xsl:choose>
</xsl:template>

<!-- 4.4.6.3 union -->
<xsl:template match="apply[*[1][self::union]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="2"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\cup </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.6.4 intersect -->
<xsl:template match="apply[*[1][self::intersect]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="3"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\cap </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.6.5 in -->
<xsl:template match="apply[*[1][self::in]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="binary">
		<xsl:with-param name="mo">\in </xsl:with-param>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="this-p" select="3"/>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.6.5 notin -->
<xsl:template match="apply[*[1][self::notin]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="binary">
		<xsl:with-param name="mo">\notin </xsl:with-param>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="this-p" select="3"/>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.6.7 subset -->
<xsl:template match="apply[*[1][self::subset]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="2"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\subseteq </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.6.8 prsubset -->
<xsl:template match="apply[*[1][self::prsubset]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="2"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\subset </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.6.9 notsubset -->
<xsl:template match="apply[*[1][self::notsubset]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="binary">
		<xsl:with-param name="this-p" select="2"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\nsubseteq </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.6.10 notprsubset -->
<xsl:template match="apply[*[1][self::notprsubset]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="binary">
		<xsl:with-param name="this-p" select="2"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\not\subset </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.6.11 setdiff -->
<xsl:template match="apply[*[1][self::setdiff]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="binary">
		<xsl:with-param name="this-p" select="2"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\setminus </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.6.12 card -->
<xsl:template match="apply[*[1][self::card]]">
	<xsl:text>|</xsl:text>
	<xsl:apply-templates select="*[2]"/>
	<xsl:text>|</xsl:text>
</xsl:template>

<!-- 4.4.6.13 cartesianproduct 4.4.10.6 vectorproduct -->
<xsl:template match="apply[*[1][self::cartesianproduct or self::vectorproduct]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="2"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\times </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<xsl:template
match="apply[*[1][self::cartesianproduct][count(following-sibling::reals)=count(following-sibling::*)]]"
priority="2">
	<xsl:apply-templates select="*[2]">
		<xsl:with-param name="p" select="5"/>
	</xsl:apply-templates>
	<xsl:text>^{</xsl:text>
	<xsl:value-of select="count(*)-1"/>
	<xsl:text>}</xsl:text>
</xsl:template>

<!-- 4.4.7.1 sum -->
<xsl:template match="apply[*[1][self::sum]]">
	<xsl:text>\sum</xsl:text><xsl:call-template name="series"/>
</xsl:template>

<!-- 4.4.7.2 product -->
<xsl:template match="apply[*[1][self::product]]">
	<xsl:text>\prod</xsl:text><xsl:call-template name="series"/>
</xsl:template>
	
<xsl:template name="series">
	<xsl:if test="lowlimit/*|interval/*[1]|condition/*">
		<xsl:text>_{</xsl:text>
		<xsl:if test="not(condition)">
			<xsl:apply-templates select="bvar"/>
			<xsl:text>=</xsl:text>
		</xsl:if>
		<xsl:apply-templates select="lowlimit/*|interval/*[1]|condition/*"/>
		<xsl:text>}</xsl:text>
	</xsl:if>
	<xsl:if test="uplimit/*|interval/*[2]">
		<xsl:text>^{</xsl:text>
		<xsl:apply-templates select="uplimit/*|interval/*[2]"/>
		<xsl:text>}</xsl:text>
	</xsl:if>
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="*[last()]"/>
</xsl:template>

<!-- 4.4.7.3 limit -->
<xsl:template match="apply[*[1][self::limit]]">
	<xsl:text>\lim_{</xsl:text>
	<xsl:apply-templates select="lowlimit|condition/*"/>
	<xsl:text>}</xsl:text>
	<xsl:apply-templates select="*[last()]"/>
</xsl:template>

<xsl:template match="apply[limit]/lowlimit" priority="3">
	<xsl:apply-templates select="../bvar/node()"/>
	<xsl:text>\to </xsl:text>
	<xsl:apply-templates/>
</xsl:template>

<!-- 4.4.7.4 tendsto -->
<xsl:template match="apply[*[1][self::tendsto]]">
	<xsl:param name="p"/>
	<xsl:call-template name="binary">
		<xsl:with-param name="this-p" select="2"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">
			<xsl:choose>
				<xsl:when test="@type='above'">\searrow </xsl:when>
				<xsl:when test="@type='below'">\nearrow </xsl:when>
				<xsl:when test="@type='two-sided'">\rightarrow </xsl:when>
				<xsl:otherwise>\to </xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.8.1 common tringonometric functions 4.4.8.3 natural logarithm -->
<xsl:template match="apply[*[1][
 self::sin or 		self::cos or 	self::tan or		self::sec or
 self::csc or 		self::cot or 	self::sinh or	 	self::cosh or
 self::tanh or 		self::coth or	self::arcsin or 	self::arccos or
 self::arctan or 	self::ln]]">
	<xsl:text>\</xsl:text>
	<xsl:value-of select="local-name(*[1])"/>
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="*[2]">
		<xsl:with-param name="p" select="7"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="sin | cos | tan | sec | csc |
								 cot | sinh | cosh | tanh | coth |
								 arcsin | arccos | arctan | ln">
	<xsl:text>\</xsl:text>
	<xsl:value-of select="local-name(.)"/>
	<xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="apply[*[1][
 self::sech or 		self::csch or		self::arccosh or
 self::arccot or 	self::arccoth or 	self::arccsc or
 self::arccsch or self::arcsec or 	self::arcsech or
 self::arcsinh or self::arctanh]]">
	<xsl:text>\mathrm{</xsl:text>
	<xsl:value-of select="local-name(*[1])"/>
	<xsl:text>\,}</xsl:text>
	<xsl:apply-templates select="*[2]">
		<xsl:with-param name="p" select="7"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="sech | csch | arccosh | arccot |
								 arccoth | arccsc |arccsch |arcsec |
								 arcsech | arcsinh | arctanh">
	<xsl:text>\mathrm{</xsl:text>
	<xsl:value-of select="local-name(.)"/>
	<xsl:text>}</xsl:text>
</xsl:template>

<!-- 4.4.8.2 exp -->
<xsl:template match="apply[*[1][self::exp]]">
	<xsl:text>e^{</xsl:text><xsl:apply-templates select="*[2]"/><xsl:text>}</xsl:text>
</xsl:template>

<!-- 4.4.8.4 log -->
<xsl:template match="apply[*[1][self::log]]">
	<xsl:text>\lg </xsl:text>
	<xsl:apply-templates select="*[last()]">
		<xsl:with-param name="p" select="7"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="apply[*[1][self::log] and logbase != 10]">
	<xsl:text>\log_{</xsl:text>
	<xsl:apply-templates select="logbase/node()"/>
	<xsl:text>}</xsl:text>
	<xsl:apply-templates select="*[last()]">
		<xsl:with-param name="p" select="7"/>
	</xsl:apply-templates>
</xsl:template>

<!-- 4.4.9.1 mean -->
<xsl:template match="apply[*[1][self::mean]]">
	<xsl:text>\langle </xsl:text>
	<xsl:for-each select="*[position()&gt;1]">
		<xsl:apply-templates select="."/>
		<xsl:if test="position() !=last()"><xsl:text>, </xsl:text></xsl:if>
	</xsl:for-each>
	<xsl:text>\rangle </xsl:text>
</xsl:template>

<!-- 4.4.9.2 sdef -->
<xsl:template match="sdev"><xsl:text>\sigma </xsl:text></xsl:template>

<!-- 4.4.9.3 variance -->
<xsl:template match="apply[*[1][self::variance]]">
	<xsl:text>\sigma(</xsl:text>
	<xsl:apply-templates select="*[2]"/>
	<xsl:text>)^2</xsl:text>
</xsl:template>

<!-- 4.4.9.5 moment -->
<xsl:template match="apply[*[1][self::moment]]">
	<xsl:text>\langle </xsl:text>
	<xsl:apply-templates select="*[last()]"/>
	<xsl:text>^{</xsl:text>
	<xsl:apply-templates select="degree/node()"/>
	<xsl:text>}\rangle</xsl:text>
	<xsl:if test="momentabout">
		<xsl:text>_{</xsl:text>
		<xsl:apply-templates select="momentabout/node()"/>
		<xsl:text>}</xsl:text>
	</xsl:if>
	<xsl:text> </xsl:text>
</xsl:template>

<!-- 4.4.10.1 vector  -->
<xsl:template match="vector">
	<xsl:text>\left(\begin{array}{c}</xsl:text>
	<xsl:for-each select="*">
		<xsl:apply-templates select="."/>
		<xsl:if test="position()!=last()"><xsl:text>\\ </xsl:text></xsl:if>
	</xsl:for-each>
	<xsl:text>\end{array}\right)</xsl:text>
</xsl:template>

<!-- 4.4.10.2 matrix  -->
<xsl:template match="matrix">
	<xsl:text>\begin{pmatrix}</xsl:text>
	<xsl:apply-templates/>
	<xsl:text>\end{pmatrix}</xsl:text>
</xsl:template>

<!-- 4.4.10.3 matrixrow  -->
<xsl:template match="matrixrow">
	<xsl:for-each select="*">
		<xsl:apply-templates select="."/>
		<xsl:if test="position()!=last()"><xsl:text> &amp; </xsl:text></xsl:if>
	</xsl:for-each>
	<xsl:if test="position()!=last()"><xsl:text>\\ </xsl:text></xsl:if>
</xsl:template>

<!-- 4.4.10.4 determinant  -->
<xsl:template match="apply[*[1][self::determinant]]">
	<xsl:text>\det </xsl:text>
	<xsl:apply-templates select="*[2]">
		<xsl:with-param name="p" select="7"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="apply[*[1][self::determinant]][*[2][self::matrix]]" priority="2">
	<xsl:text>\begin{vmatrix}</xsl:text>
	<xsl:apply-templates select="matrix/*"/>
	<xsl:text>\end{vmatrix}</xsl:text>
</xsl:template>

<!-- 4.4.10.5 transpose -->
<xsl:template match="apply[*[1][self::transpose]]">
	<xsl:apply-templates select="*[2]">
		<xsl:with-param name="p" select="7"/>
	</xsl:apply-templates>
	<xsl:text>^T</xsl:text>
</xsl:template>

<!-- 4.4.10.5 selector -->
<xsl:template match="apply[*[1][self::selector]]">
	<xsl:apply-templates select="*[2]">
		<xsl:with-param name="p" select="7"/>
	</xsl:apply-templates>
	<xsl:text>_{</xsl:text>
	<xsl:for-each select="*[position()&gt;2]">
		<xsl:apply-templates select="."/>
		<xsl:if test="position() !=last()"><xsl:text>, </xsl:text></xsl:if>
	</xsl:for-each>
	<xsl:text>}</xsl:text>
</xsl:template>

<!-- 4.4.10.7 scalarproduct 4.4.10.8 outerproduct -->
<xsl:template match="apply[*[1][self::scalarproduct or self::outerproduct]]">
	<xsl:param name="p" select="0"/>
	<xsl:call-template name="infix">
		<xsl:with-param name="this-p" select="2"/>
		<xsl:with-param name="p" select="$p"/>
		<xsl:with-param name="mo">\dot </xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- 4.4.11.2 semantics -->
<xsl:template match="semantics"><xsl:apply-templates select="*[1]"/></xsl:template>

<xsl:template match="semantics[annotation/@encoding='TeX']">
	<xsl:apply-templates select="annotation[@encoding='TeX']/node()"/>
</xsl:template>

<!-- 4.4.12.1 integers -->
<xsl:template match="integers"><xsl:text>\mathbb{Z}</xsl:text></xsl:template>

<!-- 4.4.12.2 reals -->
<xsl:template match="reals"><xsl:text>\mathbb{R}</xsl:text></xsl:template>

<!-- 4.4.12.3 rationals -->
<xsl:template match="rationals"><xsl:text>\mathbb{Q}</xsl:text></xsl:template>

<!-- 4.4.12.4 naturalnumbers -->
<xsl:template match="naturalnumbers"><xsl:text>\mathbb{N}</xsl:text></xsl:template>

<!-- 4.4.12.5 complexes -->
<xsl:template match="complexes"><xsl:text>\mathbb{C}</xsl:text></xsl:template>

<!-- 4.4.12.6 primes -->
<xsl:template match="primes"><xsl:text>\mathbb{P}</xsl:text></xsl:template>
	
<!-- 4.4.12.7 exponentiale -->
<xsl:template match="exponentiale"><xsl:text>e</xsl:text></xsl:template>

<!-- 4.4.12.8 imaginaryi -->
<xsl:template match="imaginaryi"><xsl:text>i</xsl:text></xsl:template>

<!-- 4.4.12.9 notanumber -->
<xsl:template match="notanumber"><xsl:text>NaN</xsl:text></xsl:template>

<!-- 4.4.12.10 true -->
<xsl:template match="true"><xsl:text>\mbox{true}</xsl:text></xsl:template>

<!-- 4.4.12.11 false -->
<xsl:template match="false"><xsl:text>\mbox{false}</xsl:text></xsl:template>

<!-- 4.4.12.12 emptyset -->
<xsl:template match="emptyset"><xsl:text>\emptyset </xsl:text></xsl:template>

<!-- 4.4.12.13 pi -->
<xsl:template match="pi"><xsl:text>\pi </xsl:text></xsl:template>

<!-- 4.4.12.14 eulergamma -->
<xsl:template match="eulergamma"><xsl:text>\gamma </xsl:text></xsl:template>

<!-- 4.4.12.15 infinity -->
<xsl:template match="infinity"><xsl:text>\infty </xsl:text></xsl:template>

<!-- ****************************** -->
<xsl:template name="infix" >
  <xsl:param name="mo"/>
  <xsl:param name="p" select="0"/>
  <xsl:param name="this-p" select="0"/>
  <xsl:if test="$this-p &lt; $p"><xsl:text>(</xsl:text></xsl:if>
  <xsl:for-each select="*[position()&gt;1]">
		<xsl:if test="position() &gt; 1">
			<xsl:copy-of select="$mo"/>
		</xsl:if>   
		<xsl:apply-templates select=".">
			<xsl:with-param name="p" select="$this-p"/>
		</xsl:apply-templates>
	</xsl:for-each>
  <xsl:if test="$this-p &lt; $p"><xsl:text>)</xsl:text></xsl:if>
</xsl:template>

<xsl:template name="binary" >
  <xsl:param name="mo"/>
  <xsl:param name="p" select="0"/>
  <xsl:param name="this-p" select="0"/>
  <xsl:if test="$this-p &lt; $p"><xsl:text>(</xsl:text></xsl:if>
	<xsl:apply-templates select="*[2]">
		<xsl:with-param name="p" select="$this-p"/>
	</xsl:apply-templates>
	<xsl:value-of select="$mo"/>
	<xsl:apply-templates select="*[3]">
    	<xsl:with-param name="p" select="$this-p"/>
	</xsl:apply-templates>
	<xsl:if test="$this-p &lt; $p"><xsl:text>)</xsl:text></xsl:if>
</xsl:template>

</xsl:stylesheet>
