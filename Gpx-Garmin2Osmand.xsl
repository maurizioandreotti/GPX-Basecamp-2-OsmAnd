<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.topografix.com/GPX/1/1"
	xmlns:gpx="http://www.topografix.com/GPX/1/1"
	xmlns:osmand="https://osmand.net"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">

    <xsl:output indent="yes" method="xml"/>
 
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
  <!-- remove Garmin extension section -->
      <xsl:template match="gpx:wpt">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()[not(self::gpx:extensions)]"/>
        </xsl:copy>
    </xsl:template>	
	
  <!-- create new extension section with Osmand icons -->
  
  <xsl:template match="gpx:sym">
	<extensions>
		<!-- icon mapping -->
		<xsl:choose>
		 <xsl:when test=".='Bar'">
			<osmand:icon>amenity_biergarten</osmand:icon>
		 </xsl:when>
		 <xsl:when test=".='Campground'">
			<osmand:icon>tourism_camp_site</osmand:icon>
		 </xsl:when>	
		 
		 <xsl:when test=".='Circle'">
			<osmand:icon>circle</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Crossing'">
			<osmand:icon>special_symbol_remove</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test="substring-before(.,',')='Flag'">
			<osmand:icon>special_flag_stroke</osmand:icon>
		 </xsl:when>
	
		 <xsl:when test=".='Picnic Area'">
			<osmand:icon>tourism_picnic_site</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Puzzle Cache'">
				<osmand:icon>special_flag_stroke</osmand:icon>
		 </xsl:when>	
		 
		 <xsl:when test=".='Restaurant'">
			<osmand:icon>restaurants</osmand:icon>
		 </xsl:when>			 
		 
		 <xsl:when test=".='Lodge'">
			<osmand:icon>topo_shelter</osmand:icon>
		 </xsl:when>	
		 
		 <xsl:when test=".='Mine'">
			<osmand:icon>natural_cave_entrance</osmand:icon>
		 </xsl:when>
	
		 <xsl:when test=".='Water Source'">
				<osmand:icon>building_type_pyramid</osmand:icon>
		 </xsl:when>			
		
		 <xsl:when test=".='Waypoint'">
			<osmand:icon>osmand_waypoint</osmand:icon> <!-- special_information -->
		 </xsl:when>
			
		
		
		<!-- 
		 <xsl:otherwise>
		   ... some output ....
		 </xsl:otherwise>-->
		</xsl:choose>
		
		<!-- colorize icons -->
		<xsl:choose>
		 <xsl:when test="substring-after(.,' ')='Red'">
			<osmand:color>#2196F3</osmand:color>
		 </xsl:when>
		 <xsl:when test="substring-after(.,' ')='Blue'">
			<osmand:color>#000000</osmand:color>
		 </xsl:when>
		 <xsl:when test="substring-after(.,' ')='Green'">
			<osmand:color>#00842b</osmand:color>
		 </xsl:when>
		</xsl:choose>

		 
		<osmand:displaymode>SymbolAndName</osmand:displaymode>
	</extensions>
  </xsl:template>
  

	
 </xsl:stylesheet>
 
