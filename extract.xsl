<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:loc="http://github.com/vhotspur/sxmloc"
>
<xsl:output method="text" />

<xsl:variable name="NL"><xsl:text>
</xsl:text></xsl:variable>

<xsl:template match="/">
<xsl:text>&lt;?php
// DO NOT EDIT - this file is generated with sxmloc-extract utility
// and will be overwritten on next run


</xsl:text>

<xsl:apply-templates />

<xsl:text>?&gt;
</xsl:text>

</xsl:template>



<xsl:template match="loc:g">
	<xsl:variable name="POSITION">
		<xsl:for-each select="./ancestor-or-self::*">
			<xsl:variable name="ORDER">
				<xsl:value-of select="count(preceding-sibling::*) + 1" />
			</xsl:variable>
			<xsl:if test="position() &gt; 1">
				<xsl:text>-</xsl:text>
			</xsl:if>
			<xsl:value-of select="$ORDER" />
		</xsl:for-each>
	</xsl:variable>
	
	<xsl:text>/* l10n:POSITION: </xsl:text>
	<xsl:value-of select="$POSITION" />
	<xsl:text> */</xsl:text>
	<xsl:value-of select="$NL" />
	
	<xsl:text>printf(gettext("</xsl:text>
	<xsl:apply-templates mode="l10n-text" />
	<xsl:text>"));</xsl:text>
	
	<xsl:value-of select="$NL" />
	<xsl:value-of select="$NL" />
</xsl:template>


<xsl:template match="*" mode="l10n-text">
	<xsl:text>&lt;</xsl:text><xsl:value-of select="name(.)" />
	<xsl:for-each select="@*">
		<xsl:text> </xsl:text>
		<xsl:value-of select="name(.)" />
		<xsl:text>='</xsl:text>
		<xsl:value-of select="." />
		<xsl:text>'</xsl:text>
	</xsl:for-each>
	<xsl:text>&gt;</xsl:text>
	
	<xsl:apply-templates mode="l10n-text" />
	
	<xsl:text>&lt;/</xsl:text>
	<xsl:value-of select="name(.)" />
	<xsl:text>&gt;</xsl:text>
	
</xsl:template>

<xsl:template match="text()" mode="l10n-text">
	<xsl:value-of select="." />
</xsl:template>


<!-- by default, hide all text -->
<xsl:template match="text()" />

</xsl:stylesheet>
