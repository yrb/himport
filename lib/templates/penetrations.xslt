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
          <xsl:attribute name="projectId">
            <xsl:value-of select="projectId" />
          </xsl:attribute>
          <xsl:attribute name="approvalId">
            <xsl:value-of select="approvalId" />
          </xsl:attribute>
          <xsl:attribute name="productId">
            <xsl:value-of select="productId" />
          </xsl:attribute>
          <xsl:attribute name="level">
            <xsl:value-of select="level1" />
          </xsl:attribute>
          <xsl:attribute name="number">
            <xsl:value-of select="penetrationNumber" />
          </xsl:attribute>
          <xsl:attribute name="createdBy">
            <xsl:value-of select="createdBy" />
          </xsl:attribute>
          <xsl:attribute name="createdDate">
            <xsl:value-of select="createdDate" />
          </xsl:attribute>
          <xsl:attribute name="updatedBy">
            <xsl:value-of select="updatedBy" />
          </xsl:attribute>
          <xsl:attribute name="updatedDate">
            <xsl:value-of select="updatedDate" />
          </xsl:attribute>

          <marking>
            <xsl:attribute name="id">
              <xsl:value-of select="marking[1]/markingId" />
            </xsl:attribute>
            <xsl:attribute name="attachmentId">
              <xsl:value-of select="marking[1]/attachmentId" />
            </xsl:attribute>
            <xsl:value-of select="marking[1]/coordinates" />
          </marking>

          <xsl:for-each select="attributes/attribute">
            <attribute>
              <xsl:attribute name="name">
                <xsl:value-of select="name" />
              </xsl:attribute>
              <xsl:attribute name="attributeId">
                <xsl:value-of select="stdAttributeId" />
              </xsl:attribute>
              <xsl:attribute name="type">
                <xsl:value-of select="type" />
              </xsl:attribute>
              <xsl:value-of select="selectedValue" />
            </attribute>
          </xsl:for-each>

          <xsl:for-each select="additionalProducts/additionalProduct">
            <additionalProduct>
              <xsl:attribute name="quantity">
                <xsl:value-of select="quantity" />
              </xsl:attribute>

              <xsl:value-of select="productName" />
            </additionalProduct>
          </xsl:for-each>

          <xsl:for-each select="attachments/attachment">
            <attachment>
              <xsl:attribute name="id">
                <xsl:value-of select="attachmentId" />
              </xsl:attribute>
              <xsl:attribute name="category">
                <xsl:value-of select="category" />
              </xsl:attribute>

              <xsl:value-of select="location" />
            </attachment>
          </xsl:for-each>
        </xsl:copy>
      </xsl:for-each>
    </penetrations>
  </xsl:template>
</xsl:transform>
