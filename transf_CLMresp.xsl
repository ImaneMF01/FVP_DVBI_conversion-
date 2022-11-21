<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
         xmlns:tva="urn:tva:metadata:2012"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>

  <xsl:variable name="resp_doc" select="document('response.xml')"/>

  <xsl:template match="/">
    <root>
      <LCNTableList>
          <LCNTable>
            <xsl:apply-templates select="/root/service_list" mode="lcntable"/>
          </LCNTable>
      </LCNTableList>
      <xsl:apply-templates select="/root/service_list" mode="svctable"/>
    </root>

  </xsl:template>

    <xsl:template name="ConvertDecToHex">
    <xsl:param name="index" />
    <xsl:if test="$index > 0">
      <xsl:call-template name="ConvertDecToHex">
        <xsl:with-param name="index" select="floor($index div 16)" />
      </xsl:call-template>
      <xsl:choose>
        <xsl:when test="$index mod 16 &lt; 10">
          <xsl:value-of select="$index mod 16" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="$index mod 16 = 10">a</xsl:when>
            <xsl:when test="$index mod 16 = 11">b</xsl:when>
            <xsl:when test="$index mod 16 = 12">c</xsl:when>
            <xsl:when test="$index mod 16 = 13">d</xsl:when>
            <xsl:when test="$index mod 16 = 14">e</xsl:when>
            <xsl:when test="$index mod 16 = 15">f</xsl:when>
            <xsl:otherwise>a</xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

    <xsl:template match="service_list" mode="lcntable">
<!--  from the CLMassignement.xml  access  service_list element and:
      - select serviceId and original_network_id
      - apply ConvertDecToHex template to the both param (referred as index on the template) to convert them from hex-to-dec
      - construct the ServiceURL element by concatenating 'dvb:// + the converted service_id and orig_net_id
      - construct the LCN element on the service list response for London (x_nid12339.xml)
        e.g :  <LCN channelNumber="1" serviceRef="dvb://233a..1044"/> -->
      <xsl:variable name="hex_service_id"><xsl:call-template name="ConvertDecToHex"><xsl:with-param name="index" select="service_id"/></xsl:call-template></xsl:variable>
      <xsl:variable name="hex_onid"><xsl:call-template name="ConvertDecToHex"><xsl:with-param name="index" select="original_network_id"/></xsl:call-template></xsl:variable>
      <xsl:variable name="dvburl" select="concat('dvb://',23,'..',$hex_service_id)"/>
      <xsl:variable name="sid" select="service_id"/>

      <!--Apply the previous template to construct the LCN element -->
     <LCN>
       <xsl:attribute name="channelNumber"><xsl:value-of select="lcn"/></xsl:attribute>
       <xsl:attribute name="serviceRef"><xsl:value-of select="$dvburl"/></xsl:attribute>
<!--       <xsl:attribute name="serviceRef"><xsl:value-of select="tva2012:ServiceURL"/></xsl:attribute>-->
     </LCN>
  </xsl:template>


  <xsl:template match="service_list" mode="svctable">
    <xsl:variable name="hex_service_id"><xsl:call-template name="ConvertDecToHex"><xsl:with-param name="index" select="service_id"/></xsl:call-template></xsl:variable>
      <xsl:variable name="hex_onid"><xsl:call-template name="ConvertDecToHex"><xsl:with-param name="index" select="original_network_id"/></xsl:call-template></xsl:variable>
      <xsl:variable name="dvburl" select="concat('dvb://',$hex_onid,'..',$hex_service_id)"/>
      <xsl:variable name="sid" select="service_id"/>
    <Service version="1">
      <UniqueIdentifier><xsl:value-of select="$dvburl"/></UniqueIdentifier>
      <ServiceName><xsl:value-of select="document('response.xml')//tva:ServiceInformation[tva:ServiceURL=$dvburl]/tva:Name"/></ServiceName>
    </Service>
  </xsl:template>



</xsl:stylesheet>







<!--        <Name xml:lang="en">BBC</Name>-->
<!--        <ProviderName xml:lang="en">BBC</ProviderName>-->
<!--        <RegionList Version="1">-->
<!--		  <Region countryCodes="GBR" regionID="England">-->
<!--			<RegionName>England</RegionName>-->
<!--			<Region regionId="primary" selectable="false">-->
<!--				<RegionName>London</RegionName>-->
<!--				<Region regionId="secondary" selectable="false">-->
<!--					<RegionName>Greater London</RegionName>-->
<!--				</Region>-->
<!--			</Region>-->
<!--		  </Region>-->
<!--	    </RegionList>-->
<!--        <LCNTableList>-->
<!--          <LCNTable>-->
<!--            <xsl:apply-templates select="/tva2012:TVAMain/tva2012:ProgramDescription/tva2012:ServiceInformationTable/tva2012:ServiceInformation" mode="lcntable"/>-->
<!--          </LCNTable>-->
<!--        </LCNTableList>-->
<!--        <ContentGuideSourceList>-->
<!--          <xsl:apply-templates select="/tva2012:TVAMain/tva2012:ProgramDescription/tva2012:ServiceInformationTable/tva2012:ServiceInformation" mode="cgsl"/>-->
<!--        </ContentGuideSourceList>-->
<!--          <xsl:apply-templates select="/tva2012:TVAMain/tva2012:ProgramDescription/tva2012:ServiceInformationTable/tva2012:ServiceInformation" mode="service"/>-->
<!--      </ServiceList>-->
<!--    </root>-->
<!--  </xsl:template>-->

<!--  <xsl:template xmlns="urn:dvb:metadata:servicediscovery:2021" match="tva2012:ServiceInformation" mode="lcntable">-->
<!--     <LCN>-->
<!--       <xsl:attribute name="channelNumber"><xsl:value-of select="count(preceding-sibling::*)+1"/></xsl:attribute>-->
<!--       <xsl:attribute name="serviceRef"><xsl:value-of select="tva2012:ServiceURL"/></xsl:attribute>-->
<!--     </LCN>-->
<!--  </xsl:template>-->

<!--  <xsl:template xmlns="urn:dvb:metadata:servicediscovery:2021" match="tva2012:ServiceInformation" mode="cgsl">-->
<!--    <xsl:comment><xsl:value-of select="tva2012:Name"/></xsl:comment>-->
<!--    <ContentGuideSource>-->
<!--      <xsl:attribute name="CGSID"><xsl:value-of select="concat('cgsid_',count(preceding-sibling::*)+1)"/></xsl:attribute>-->
<!--      <ProviderName xml:lang="en"><xsl:value-of select="tva2012:Owner"/></ProviderName>-->
<!--      <ScheduleInfoEndpoint contentType="application/xml">-->
<!--        <URI>http://api-explorer.cloud.digitaluk.co.uk/api/production/12339/schedule/<xsl:value-of select="@serviceId"/>/</URI>-->
<!--      </ScheduleInfoEndpoint>-->
<!--      <ProgramInfoEndpoint contentType="application/xml"/>-->
<!--    </ContentGuideSource>-->
<!--  </xsl:template>-->

<!--    <xsl:template xmlns="urn:dvb:metadata:servicediscovery:2021" match="tva2012:ServiceGenre" >-->
<!--        <ServiceGenre>-->
<!--            <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>-->
<!--            <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>-->

<!--        </ServiceGenre>-->
<!--    </xsl:template>-->

<!--  <xsl:template xmlns="urn:dvb:metadata:servicediscovery:2021" match="tva2012:ServiceInformation" mode="service">-->
<!--    <xsl:comment><xsl:value-of select="tva2012:Name"/></xsl:comment>-->
<!--      <Service version="1">-->
<!--    <UniqueIdentifier><xsl:value-of select="tva2012:ServiceURL"/></UniqueIdentifier>-->
<!--    <ServiceGenre type ="main" href="urn:fvc:metadata:cs:ServiceTypeCS:2019:linear"/>-->
<!--          <xsl:apply-templates select="tva2012:ServiceGenre[position()>1]"/>-->
<!--    <RelatedMaterial xsi:type="tva2:ExtendedRelatedMaterialType">-->
<!--&lt;!&ndash;         <xsl:attribute name="href"><xsl:value-of select="tva2012:ServiceGenre/@href"/></xsl:attribute>&ndash;&gt;-->
<!--&lt;!&ndash;    <HowRelated href="urn:tva:metadata:cs:HowRelatedCS:2012:10.5"/>&ndash;&gt;-->
<!--      <HowRelated>-->
<!--        <xsl:attribute name="href"><xsl:value-of select="tva2012:RelatedMaterial/tva2012:HowRelated/@href"/> </xsl:attribute>-->
<!--      </HowRelated>-->
<!--    <MediaLocator>-->
<!--      <MediaUri contentType="application/vnd.dvb.ait+xml"><xsl:value-of select="tva2012:RelatedMaterial/tva2012:MediaLocator/tva2012:MediaUri[@contentType='application/vnd.dvb.ait+xml']"/>-->
<!--      </MediaUri>-->
<!--    </MediaLocator>-->
<!--    </RelatedMaterial>-->
<!--    <ServiceInstance priority="1">-->
<!--      <SourceType>urn:dvb:metadata:source:dvb-t</SourceType>-->
<!--      <DVBTDeliveryParameters>-->
<!--          <DVBTriplet origNetId="9018" tsId=""><xsl:attribute name="ServiceId"><xsl:value-of select="@serviceId"/></xsl:attribute></DVBTriplet>-->
<!--        <TargetCountry>UK</TargetCountry>-->
<!--      </DVBTDeliveryParameters>-->
<!--    </ServiceInstance>-->
<!--    <ServiceName xml:lang="en"><xsl:value-of select="tva2012:Name"/></ServiceName>-->
<!--    <ProviderName><xsl:value-of select="tva2012:Owner"/></ProviderName>-->
<!--    <DisplayName><xsl:value-of select="tva2012:Name"/></DisplayName>-->
<!--    <RelatedMaterial>-->
<!--      <tva:HowRelated href="urn:dvb:metadata:cs:HowRelatedCS:2019:1001.2"/>-->
<!--      <tva:MediaLocator>-->
<!--        <tva:MediaUri contentType="image/png"><xsl:value-of select="tva2012:RelatedMaterial/tva2012:MediaLocator/tva2012:MediaUri[@contentType='image/png']"/></tva:MediaUri>-->
<!--      </tva:MediaLocator>-->
<!--    </RelatedMaterial>-->
<!--    <ContentGuideServiceRef><xsl:attribute name="CGSID"><xsl:value-of select="concat('cgsid_',count(preceding-sibling::*)+1)"/></xsl:attribute>-->
<!--    </ContentGuideServiceRef>-->
<!--      </Service>-->


<!--  </xsl:template>-->

<!--</xsl:stylesheet>-->






