<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" encoding="UTF-8" indent="yes" />

  <xsl:template match="/">
    <projects>
      <xsl:for-each select="//project">
        <xsl:copy>
          <xsl:attribute name="id">
            <xsl:value-of select="projectId" />
          </xsl:attribute>
          <xsl:copy-of select="*[not(self::penetrations) and not(self::reports)]" />
        </xsl:copy>
      </xsl:for-each>
    </projects>
  </xsl:template>
</xsl:transform>
