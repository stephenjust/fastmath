<?xml version='1.0' encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:m="http://www.w3.org/1998/Math/MathML"
                version='1.0'>

<!-- ====================================================================== -->
<!-- $id: glayout.xsl, 2002/17/05 Exp $
     This file is part of the XSLT MathML Library distribution.
     See ./README or http://www.raleigh.ru/MathML/mmltex for
     copyright and other information                                        -->
<!-- ====================================================================== -->

<xsl:template match="m:mfrac">
	<xsl:text>(</xsl:text>
	<xsl:apply-templates select="./*[1]"/>
	<xsl:text>) / (</xsl:text>
	<xsl:apply-templates select="./*[2]"/>
	<xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="m:mroot">
	<xsl:choose>
		<xsl:when test="count(./*)=2">
			<xsl:text>\sqrt[</xsl:text>
			<xsl:apply-templates select="./*[2]"/>
			<xsl:text>]{</xsl:text>	
			<xsl:apply-templates select="./*[1]"/>
			<xsl:text>}</xsl:text>	
		</xsl:when>
		<xsl:otherwise>
		<!-- number of argumnets is not 2 - code 25 -->
			<xsl:message>exception 25:</xsl:message>
			<xsl:text>\text{exception 25:}</xsl:text> 
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="m:msqrt">
	<xsl:text>sqrt(</xsl:text>
	<xsl:apply-templates/>
	<xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="m:mfenced">
	<xsl:text>(</xsl:text>
	<xsl:choose>
		<xsl:when test="count(./*)>1">
			<xsl:variable name="symbol">
				<xsl:choose>
					<xsl:when test="@separators">
						<xsl:call-template name="startspace">
							<xsl:with-param name="symbol" select="@separators"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>,</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:for-each select="./*">
				<xsl:apply-templates select="."/>
				<xsl:if test="not(position()=last())">
					<xsl:choose>
						<xsl:when test="position()>string-length(symbol)">
							<xsl:value-of select="substring($symbol,string-length($symbol))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="substring($symbol,position(),1)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="m:mphantom">
	<xsl:text>\phantom{</xsl:text>
	<xsl:apply-templates/>
	<xsl:text>}</xsl:text>
</xsl:template>

<xsl:template match="m:menclose">
	<xsl:choose>
		<xsl:when test="@notation = 'actuarial'">
			<xsl:text>\overline{</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>\hspace{.2em}|}</xsl:text>
		</xsl:when>
		<xsl:when test="@notation = 'radical'">
			<xsl:text>\sqrt{</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>}</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>\overline{)</xsl:text>
			<xsl:apply-templates/>
			<xsl:text>}</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="m:mrow">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="m:mstyle">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="m:merror">
	<xsl:apply-templates/>
</xsl:template>

</xsl:stylesheet>
