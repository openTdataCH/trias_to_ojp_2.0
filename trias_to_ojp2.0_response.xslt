<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:siri="http://www.siri.org.uk/siri" xmlns:ojp="http://www.vdv.de/ojp" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="ojp:OJP">
		<Trias version="1.3" xmlns="http://www.vdv.de/trias" xmlns:siri="http://www.siri.org.uk/siri" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.vdv.de/trias  file:///C:/Users/ue71603/MG_Daten/github/TRIAS/Trias.xsd">
			<ServiceDelivery>
      <siri:ResponseTimestamp><xsl:value-of select="//siri:ResponseTimestamp[1]"/></siri:ResponseTimestamp>
      <siri:ProducerRef><xsl:value-of select="//siri:ProducerRef[1]"/></siri:ProducerRef>
      <Language>en</Language>
    
				<xsl:apply-templates select="ojp:OJPResponse"/>
			</ServiceDelivery>
		</Trias>
	</xsl:template>
	<xsl:template match="ojp:OJPResponse">
		<xsl:apply-templates select="siri:ServiceDelivery"/>
	</xsl:template>
	<xsl:template match="siri:ServiceDelivery">
	
		<xsl:apply-templates select="ojp:OJPStopEventDelivery"/>	</xsl:template>
	<xsl:template match="ojp:OJPStopEventDelivery">
	<DeliveryPayload>
		<StopEventResponse>
			<xsl:apply-templates select="ojp:StopEventResponseContext"/>
			<xsl:apply-templates select="ojp:StopEventResult"/>
		</StopEventResponse>
		
		</DeliveryPayload>

	</xsl:template>
	<xsl:template match="ojp:StopEventResponseContext">
		<StopEventResponseContext>
			<xsl:apply-templates select="ojp:Places"/>
		</StopEventResponseContext>
	</xsl:template>
	<xsl:template match="ojp:Places">
		<Locations>
			<xsl:apply-templates select="ojp:Place"/>
		</Locations>
	</xsl:template>
	
			<!--*********************************************-->

	<xsl:template match="ojp:StopEventResult">
	<StopEventResult>
			<ResultId><xsl:value-of select="ojp:Id"/></ResultId>
		<xsl:apply-templates select="ojp:StopEvent"/>
		</StopEventResult>
	</xsl:template>
	
	
			<!--*********************************************-->

	<xsl:template match="ojp:Place">
		<Location>
			<xsl:apply-templates select="ojp:StopPlace"/>
			<xsl:apply-templates select="ojp:StopPoint"/>

			<LocationName><Text><xsl:value-of select="ojp:Name/ojp:Text"/></Text></LocationName>
			<xsl:apply-templates select="ojp:GeoPosition"/>
		</Location>
		
				<!--*********************************************-->

	</xsl:template>
	<xsl:template match="ojp:GeoPosition">
		<GeoPosition>
			<Longitude><xsl:value-of select="siri:Longitude"/></Longitude>
			<Latitude><xsl:value-of select="siri:Latitude"/></Latitude>
		</GeoPosition>
	</xsl:template>
			<!--*********************************************-->

	<xsl:template match="ojp:StopPlace">
	<StopPlace>
		<StopPlaceRef><xsl:value-of select="ojp:StopPlaceRef"/></StopPlaceRef>
		<StopPlaceName><Text><xsl:value-of select="ojp:StopPlaceName"/></Text></StopPlaceName>
		<!-- todo only when private codes exist -->
		<PrivateCode><System><xsl:value-of select="ojp:PrivateCode/ojp:System"/></System>
		<Value><xsl:value-of select="ojp:PrivateCode/ojp:Value"/></Value></PrivateCode>
		</StopPlace>
	</xsl:template>
			<!--*********************************************-->

	
		<xsl:template match="ojp:StopPoint">
		<StopPoint>
		<StopPointRef><xsl:value-of select="siri:StopPointRef"/></StopPointRef>
		<StopPointName><Text><xsl:value-of select="ojp:StopPointName/ojp:Text"/></Text></StopPointName>
		
		<PrivateCode><System><xsl:value-of select="ojp:PrivateCode/ojp:System"/></System>
		<Value><xsl:value-of select="ojp:PrivateCode/ojp:Value"/></Value></PrivateCode>
		</StopPoint>

	</xsl:template>
			<!--*********************************************-->

	<xsl:template match="ojp:CallAtStop">
		<CallAtStop>
		<StopPointRef>xsl:value-of select="siri:StopPointRef"/></StopPointRef>
				<StopPointName><Text><xsl:value-of select="ojp:StopPointName/ojp:Text"/></Text></StopPointName>
		</CallAtStop>
	</xsl:template>
		<!--*********************************************-->

	<xsl:template match="ojp:StopEvent">
		<StopEvent>
			<!--<xsl:apply-templates select="ojp:PreviousCall"/>-->
			<xsl:apply-templates select="ojp:ThisCall"/>
			<!-- <xsl:apply-templates select="ojp:OnwardCall"/>-->
		</StopEvent>
	<xsl:apply-templates select="ojp:Service"/>

	</xsl:template>
	
		<!--*********************************************-->
	<xsl:template match="ojp:ThisCall">
		<ThisCall>
			<xsl:apply-templates select="ojp:CallAtStop"/>
		</ThisCall>
	</xsl:template>
	<xsl:template match="ojp:Service">
		<Service/>
	</xsl:template>
	
	
</xsl:stylesheet>