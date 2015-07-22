<!-- 
Rymer
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exist="http://exist.sourceforge.net/NS/exist" version="1.0">
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:variable name="file"><xsl:value-of select="//filename"/></xsl:variable>
    <xsl:template match="//filename"/>
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="TEI">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
	<xsl:template match="teiHeader" />
    <xsl:template match="text">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="div">
				<div>
					<xsl:apply-templates/>
				</div>
    </xsl:template>
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="emph">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    <xsl:template match="person">
        <div>
            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
			<xsl:apply-templates/>
		</div>
    </xsl:template>	
    <xsl:template match="person/persName">
        <xsl:choose>
            <xsl:when test="@type='secondary'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <h3><xsl:apply-templates/></h3>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="person/persName[@type='secondary']/addName">
        <h4><xsl:apply-templates/></h4>
    </xsl:template>
    <xsl:template match="p/persName">
    	<xsl:variable name="corresp"><xsl:value-of select="@corresp"/></xsl:variable>
    	<xsl:variable name="person"><xsl:value-of select="substring-after($corresp, '#')"/></xsl:variable>
        <a>
            <xsl:attribute name="class">person-link</xsl:attribute>
            <xsl:attribute name="href">person.php?file=<xsl:value-of select="$file"/>&amp;p=<xsl:value-of select="$person"/></xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    <xsl:template match="note">
    	<xsl:choose>
    		<xsl:when test="@type='spoiler'">
    			<a class="spoiler-toggle">Show Spoilers</a>
    			<div class="spoiler" style="display:none;">
    				<xsl:apply-templates/>
    			</div>
    		</xsl:when>
    		<xsl:otherwise>
        		<xsl:apply-templates/>
        	</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="addname">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="forename">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="surname">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>