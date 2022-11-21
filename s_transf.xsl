<!--<?xml version="1.0" encoding="UTF-8"?>-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="urn:tva:metadata:2012"
                xmlns:tva2012="urn:tva:metadata:2012"
                xmlns:tva2="urn:tva:metadata:extended:2012"
                xmlns:tva="urn:tva:metadata:2019"
                xmlns:tva2019="urn:tva:metadata:2019"
         xmlns:mpeg7="urn:tva:mpeg7:2008" xml:lang="eng"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<!--  <xsl:output omit-xml-declaration="yes" indent="yes"/>-->
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
    <xsl:strip-space elements="*"/>

  <xsl:template match="/">
    <TVAMain>
        <ProgramDescription>
            <ProgramInformationTable xml:lang="en">
                <xsl:apply-templates select="/tva2012:TVAMain/tva2012:ProgramDescription/tva2012:ProgramInformationTable" mode="proginfo"/>
            </ProgramInformationTable>

            <ProgramLocationTable xml:lang="en">
                <xsl:apply-templates select="/tva2012:TVAMain/tva2012:ProgramDescription/tva2012:ProgramLocationTable" mode="plt"/>
            </ProgramLocationTable>

      </ProgramDescription>
    </TVAMain>
  </xsl:template>

    <xsl:template match="/tva2012:TVAMain/tva2012:ProgramDescription/tva2012:ProgramInformationTable/tva2012:BasicDescription/tva2012:Title">
        <xsl:copy>
            <xsl:apply-templates select="item[not(@type = preceding-sibling::item/@type)]" />
        </xsl:copy>
    </xsl:template>


    <xsl:template xmlns="urn:tva:metadata:2012" match="tva2012:ProgramInformation" mode="proginfo">
<!--    <xsl:comment><xsl:value-of select="tva2012:Title"/></xsl:comment>-->
    <ProgramInformation>
       <xsl:attribute name="programId"><xsl:value-of select="@programId"/></xsl:attribute>
        <BasicDescription>

            <Title type="main"><xsl:value-of select="tva2012:BasicDescription/tva2012:Title"/></Title>
<!--               <Title><xsl:value-of select="//tva2012:Title[@type != preceding-sibling::tva2012:Title/@type]"/></Title>-->
            <Title type="secondary"><xsl:value-of select="tva2012:BasicDescription/tva2012:Title[2]"/></Title>
            <Synopsis lenght="short"><xsl:value-of select="tva2012:BasicDescription/tva2012:Synopsis"/></Synopsis>
            <Synopsis lenght="medium"><xsl:value-of select="tva2012:BasicDescription/tva2012:Synopsis[2]"/></Synopsis>
            <Genre href="urn:dvb:metadata:cs:ContentSubject:2019:3" type="main"/>
            <RelatedMaterial>
                <HowRelated href="urn:tva:metadata:cs:HowRelatedCS:2012:19"/>
                <MediaLocator>
                    <MediaUri contentType="image/png">
                        <xsl:value-of select="tva2012:BasicDescription/tva2012:RelatedMaterial/tva2012:MediaLocator/tva2012:MediaUri"/></MediaUri>
                </MediaLocator>

            </RelatedMaterial>


        </BasicDescription>
    </ProgramInformation>
</xsl:template>
        <xsl:template xmlns="urn:tva:metadata:2012" match="tva2012:ProgramDescription/tva2012:ProgramLocationTable" mode="plt">
            <Schedule>
                <xsl:attribute name="serviceIDRef"><xsl:value-of select="tva2012:Schedule/@serviceIDRef"/></xsl:attribute>
                <xsl:attribute name="start"><xsl:value-of select="tva2012:Schedule/@start"/></xsl:attribute>
                <xsl:attribute name="end"><xsl:value-of select="tva2012:Schedule/@end"/></xsl:attribute>

                <ScheduleEvent>
                    <Program> <xsl:attribute name="crid"><xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:Program/@crid"/></xsl:attribute></Program>
                    <ProgramURL>
                        <xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:ProgramURL"/></ProgramURL>
                    <InstanceDesription>
                        <CaptionLanguage><xsl:attribute name="closed"> <xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:InstanceDescription/tva2012:CaptionLanguage/@closed"/></xsl:attribute>
                            <xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:InstanceDescription/tva2012:CaptionLanguage"></xsl:value-of>
                        </CaptionLanguage>
                        <AVAttributes>
                            <AudioAttributes>
                                <MixType>
                                    <xsl:attribute name="href"><xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:InstanceDescription/tva2012:AVAttributes/tva2012:AudioAttributes/tva2012:MixType/@href"/></xsl:attribute>
                                </MixType>

                                <AudioLanguage>
                                    <xsl:attribute name="purpose"><xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:InstanceDescription/tva2012:AVAttributes/tva2012:AudioAttributes/tva2012:AudioLanguage/@purpose"/></xsl:attribute>
                                     <xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:InstanceDescription/tva2012:AVAttributes/tva2012:AudioAttributes/tva2012:AudioLanguage"></xsl:value-of>
                                </AudioLanguage>
                                </AudioAttributes>
                                 <VideoAttributes>
                                     <HorizontalSize><xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:InstanceDescription/tva2012:AVAttributes/tva2012:VideoAttributes/tva2012:HorizontalSize"></xsl:value-of>
                                     </HorizontalSize>
                                     <VerticalSize>
                                         <xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:InstanceDescription/tva2012:AVAttributes/tva2012:VideoAttributes/tva2012:VerticalSize"></xsl:value-of>
                                     </VerticalSize>
                                     <AspectRatio><xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:InstanceDescription/tva2012:AVAttributes/tva2012:VideoAttributes/tva2012:AspectRatio"></xsl:value-of>
                                     </AspectRatio>
                                 </VideoAttributes>
                                <CaptioningAttributes>
                                    <Coding href="urn:tva:metadata:cs:CaptionCodingFormatCS:2015:2.1"/>
                                </CaptioningAttributes>
                        </AVAttributes>
                        <OtherIdentifier>
                            <xsl:attribute name="type"><xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:InstanceDescription/tva2012:OtherIdentifier/@type"/></xsl:attribute>
                            <xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:InstanceDescription/tva2012:OtherIdentifier"></xsl:value-of>
                        </OtherIdentifier>
                        <OtherIdentifier>
                            <xsl:attribute name="type"><xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:InstanceDescription/tva2012:OtherIdentifier[2]/@type"/></xsl:attribute>
                            <xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:InstanceDescription/tva2012:OtherIdentifier[2]"></xsl:value-of>
                        </OtherIdentifier>
                    </InstanceDesription>

                    <PublishedStartTime>
                         <xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:PublishedStartTime"></xsl:value-of>
                    </PublishedStartTime>
                    <PublishedDuration>
                         <xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:PublishedDuration"></xsl:value-of>
                    </PublishedDuration>
                    <StartOfAvailability>
                       <xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:StartOfAvailability"></xsl:value-of>
                    </StartOfAvailability>
                    <EndOfAvailability>
                         <xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:EndOfAvailability"></xsl:value-of>
                    </EndOfAvailability>

                    <FirstShowing>
                         <xsl:attribute name="type"><xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:FirstShowing/@value"/></xsl:attribute>
                    </FirstShowing>
                </ScheduleEvent>
            </Schedule>
        </xsl:template>

        <xsl:template xmlns="urn:tva:metadata:2012" match="tva2012:ProgramDescription/tva2012:ProgramLocationTable" mode="plt">
            <OnDemandProgram>
               <xsl:attribute name="serviceIDRef"><xsl:value-of select="tva2012:OnDemandProgram/@serviceIDRef"/></xsl:attribute>
            </OnDemandProgram>
            <Program>
             <xsl:attribute name="crid"><xsl:value-of select="tva2012:Schedule/tva2012:ScheduleEvent/tva2012:Program/@crid"/></xsl:attribute>
            </Program>
            <ProgramURL>
                <xsl:attribute name="contentType"><xsl:value-of select="tva2012:OnDemandProgram/tva2012:ProgramURL/@contentType"/></xsl:attribute>
                <xsl:value-of select="tva2012:OnDemandProgram/tva2012:ProgramURL"></xsl:value-of>
            </ProgramURL>
            <AuxiliaryURL>
                <xsl:attribute name="contentType"><xsl:value-of select="tva2012:OnDemandProgram/tva2012:AuxiliaryURL/@contentType"/></xsl:attribute>
                <xsl:value-of select="tva2012:OnDemandProgram/tva2012:AuxiliaryURL"></xsl:value-of>
            </AuxiliaryURL>
            <InstanceDescription>
              <Genre>
                  <xsl:attribute name="href"><xsl:value-of select="tva2012:OnDemandProgram/tva2012:InstanceDescription/tva2012:Genre/@href"/></xsl:attribute></Genre>
                <Genre>
                  <xsl:attribute name="href"><xsl:value-of select="tva2012:OnDemandProgram/tva2012:InstanceDescription/tva2012:Genre[2]/@href"/></xsl:attribute>
              </Genre>

                <AVAttributes>
                    <AudioAttributes>
                    <MixType>
                      <xsl:attribute name="href"><xsl:value-of select="tva2012:OnDemandProgram/tva2012:InstanceDescription/tva2012:AVAttributes/tva2012:AudioAttributes/tva2012:MixType/@href"/></xsl:attribute>
                    </MixType>
                        <AudioLanguage>
                            <xsl:attribute name="href"><xsl:value-of select="tva2012:OnDemandProgram/tva2012:InstanceDescription/tva2012:AVAttributes/tva2012:AudioAttributes/tva2012:AudioLanguage/@purpose"/></xsl:attribute>
                        </AudioLanguage>
                    </AudioAttributes>
                    <VideoAttributes>
                        <HorizontalSize>
                            <xsl:value-of select="tva2012:OnDemandProgram/tva2012:InstanceDescription/tva2012:AVAttributes/tva2012:VideoAttributes/tva2012:HorizontalSize"/>
                        </HorizontalSize>
                        <VerticalSize>
                           <xsl:value-of select="tva2012:OnDemandProgram/tva2012:InstanceDescription/tva2012:AVAttributes/tva2012:VideoAttributes/tva2012:VerticalSize"/>
                        </VerticalSize>
                        <AspectRatio>
                           <xsl:value-of select="tva2012:OnDemandProgram/tva2012:InstanceDescription/tva2012:AVAttributes/tva2012:VideoAttributes/tva2012:AspectRatio"/>
                        </AspectRatio>
                    </VideoAttributes>
                </AVAttributes>
                <PublishedDuration>
                     <xsl:value-of select="tva2012:OnDemandProgram/tva2012:PublishedDuration"/>
                </PublishedDuration>
                <StartOfAvailability>
                    <xsl:value-of select="tva2012:OnDemandProgram/tva2012:StartOfAvailability"/>
                </StartOfAvailability>
                <EndOfAvailability>
                    <xsl:value-of select="tva2012:OnDemandProgram/tva2012:EndOfAvailability"/>
                </EndOfAvailability>
                <DeliveryMode>
                     <xsl:value-of select="tva2012:OnDemandProgram/tva2012:DeliveryMode"/>
                </DeliveryMode>
                <Free>
                    <xsl:attribute name="href"><xsl:value-of select="tva2012:OnDemandProgram/tva2012:InstanceDescription/tva2012:AVAttributes/tva2012:AudioAttributes/tva2012:MixType/@href"/></xsl:attribute>
                    <xsl:value-of select="tva2012:OnDemandProgram/tva2012:Free"/>
                </Free>
            </InstanceDescription>
        </xsl:template>


</xsl:stylesheet>