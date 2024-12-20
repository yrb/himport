<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" encoding="UTF-8" indent="yes" />

  <xsl:template match="/">
    <penetrations>
      <xsl:for-each select="//penetration">
        <xsl:copy>
          <xsl:attribute name="id">
            <xsl:value-of select="penetrationId" />
          </xsl:attribute>

        </xsl:copy>
      </xsl:for-each>
    </penetrations>
  </xsl:template>
</xsl:transform>
