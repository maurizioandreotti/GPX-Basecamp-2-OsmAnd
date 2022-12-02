<?xml version="1.0"?>
	
<!--
	Copyright © Maurizio Andreotti
	GNU General Public License, version 2 (GPL-2.0)
	http://opensource.org/licenses/gpl-2.0.php
-->
	
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.topografix.com/GPX/1/1"
	xmlns:gpx="http://www.topografix.com/GPX/1/1"
	xmlns:osmand="https://osmand.net"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">
	<xsl:output method="xml" encoding="ASCII" indent="yes" />
 
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
  <!-- remove Garmin Basecamp extension section -->
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
		
		<!-- to be completed:
			icone speciali osmand 
				special_arrow_up_right
		
			basecamp icons  to be mapped:
			    <name>Blue Elllipse</name> 	<sym>Oval, Blue</sym>
				<name>Blue Flag</name>		<sym>Flag, Blue</sym>
				<name>Blue Lens</name> 		<sym>Pin, Blue</sym>
				<name>Car service (service  truck icon)</name>	<sym>Wrecker</sym>
				<name>Circle top red, bottom green</name>     <sym>Navaid, Red/Green</sym>
				<name>circle top half green, bottom half red</name>     <sym>Navaid, Green/Red</sym>
				<name>Circle top red, bottom white</name>   <sym>Navaid, Red/White</sym>
			    <name>Circle top white, bottom green</name>   <sym>Navaid, White/Green</sym>
			    <name>Circle top white, bottom red</name>    <sym>Navaid, White/Red</sym>
				<name>Fast Food (drink icon)</name>     <sym>Fast Food</sym>
				<name>exit (light blue square)</name>   <sym>Exit</sym>
				<sym>Weed Bed</sym>
				<sym>Funicular</sym>
				<sym>Amusement Park</sym>
				<sym>Oil Field</sym>
				<sym>Dropoff</sym>
				<sym>Trail Head</sym>
				<sym>Pharmacy</sym>
				<sym>Pizza</sym>
				<sym>Radio Beacon</sym>
				<sym>Winery</sym>
				<sym>Zoo</sym>
				
		-->
			
		<!-- DRAWINGS -->
		
		<xsl:when test=".='Amusement Park'">
			<osmand:icon>air_transport</osmand:icon>
		 </xsl:when>	
		
		
		<!-- Aviation -->
				 <xsl:when test=".='Airport'">
					<osmand:icon>air_transport</osmand:icon>
					<osmand:background>circle</osmand:background>
				 </xsl:when>
				<!-- Aviation grey empty circle  - green field --> 
				 <xsl:when test=".='Soft Field'"> 
					<osmand:icon>air_transport</osmand:icon>
					<osmand:color>grey</osmand:color>
					<osmand:background>circle</osmand:background>
				 </xsl:when>
				 
				<!-- Aviation R - private camp --> 
				 <xsl:when test=".='Private Field'">Airport
					<osmand:icon>air_transport</osmand:icon>
					<osmand:color>grey</osmand:color>
					<osmand:background>circle</osmand:background>
				 </xsl:when>		 
				 
				<!-- Heliport --> 
				 <xsl:when test=".='Heliport'">Airport
					<osmand:icon>aeroway_helipad</osmand:icon>
					<osmand:color>grey</osmand:color>
					<osmand:background>circle</osmand:background>
				 </xsl:when>
		 
		 <!-- Banks -->
				 <!-- Bank (Dollar icon) -->
				 <xsl:when test=".='Bank'">
					<osmand:icon>finance money_bank2</osmand:icon>
				 </xsl:when>		  
				 <!-- Bank (Euro icon) -->
				 <xsl:when test=".='Bank, Euro'">
					<osmand:icon>finance money_bank2</osmand:icon>
				 </xsl:when>	
				 <!-- Bank (Pound icon) -->
				 <xsl:when test=".='Bank, Pound'">
					<osmand:icon>finance money_bank2</osmand:icon>
				 </xsl:when>		
				 <!-- Bank (Yen icon) -->
				 <xsl:when test=".='Bank, Yen'">
					<osmand:icon>finance money_bank2</osmand:icon>
				 </xsl:when>	

		 
		 <xsl:when test=".='Bar'">
			<osmand:icon>amenity_biergarten</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Beacon'">
			<osmand:icon>beacon</osmand:icon> 
		 </xsl:when>
		 		 
		 <xsl:when test=".='Beach'">
			<osmand:icon>beach tourist_beach2</osmand:icon>
		 </xsl:when>		 
		 
		 <xsl:when test=".='Bell'">
			<osmand:icon>bell</osmand:icon> <!-- bell_tower -->
		 </xsl:when>
		 
		 <xsl:when test=".='Bike Trail'">
			<osmand:icon>topo_trailhead</osmand:icon> 
		 </xsl:when>		 
		 
		 <xsl:when test=".='Bridge'">
			<osmand:icon>bridge</osmand:icon> 
		 </xsl:when>		
		 
		 <!-- bus stop -->
		 <xsl:when test=".='Ground Transportation'">
			<osmand:icon>transport_bus_stop</osmand:icon> 
		 </xsl:when>	
		 

		 <xsl:when test=".='Building'">
			<osmand:icon>building</osmand:icon> 
		 </xsl:when>	
		 
		 <xsl:when test=".='Bowling'">
			<osmand:icon>sport_bowling</osmand:icon> 
		 </xsl:when>
		 
		 <xsl:when test=".='Ball Park'">
			<osmand:icon>sport_basebal</osmand:icon> 
		 </xsl:when>
		 
		 <xsl:when test=".='Campground'">
			<osmand:icon>tourism_camp_site</osmand:icon>
		 </xsl:when>	

		 <xsl:when test=".='Car'">
			<osmand:icon>car</osmand:icon>
		 </xsl:when>	

		 <xsl:when test=".='Car mechanic'">
			<osmand:icon>shop_car_repair</osmand:icon>
		 </xsl:when>

		 <xsl:when test=".='Car Rental'">
			<osmand:icon>amenity_car_rental</osmand:icon>
		 </xsl:when>

		 <xsl:when test=".='Church'">
			<osmand:icon>building_type_church</osmand:icon>
		 </xsl:when>

		 <xsl:when test=".='Cemetery'">
			<osmand:icon>cemetery</osmand:icon>
		 </xsl:when>		
		 
		 <!-- city -->
				 <xsl:when test=".='City (Large)'">
					<osmand:icon>circle</osmand:icon>
				 </xsl:when>
				 <xsl:when test=".='City (Medium)'">
					<osmand:icon>circle</osmand:icon>
				 </xsl:when>
				 <xsl:when test=".='City (Small)'">
					<osmand:icon>circle</osmand:icon>
				 </xsl:when>
				 <xsl:when test=".='City (Capitol)'">
					<osmand:icon>star</osmand:icon>
				 </xsl:when>
				 <xsl:when test=".='City Hall'">
					<osmand:icon>amenity_townhall</osmand:icon>
				 </xsl:when>
				 <xsl:when test=".='Ghost Town'">
					<osmand:icon>star</osmand:icon>
				 </xsl:when>
		 
	 

		 <xsl:when test=".='Coast Guard'">
			<osmand:icon>lifeguard_base</osmand:icon>
		 </xsl:when>

		 
		 <xsl:when test=".='Crossing'">
			<osmand:icon>special_symbol_remove</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Dam'">
			<osmand:icon>dam</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Dock'">
			<osmand:icon>seamark_harbour_ferry</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Ferry'">
			<osmand:icon>seamark_harbour_ferry</osmand:icon>
		 </xsl:when>
		 
			 
		 <xsl:when test=".='Fitness Center'">
			<osmand:icon>sport_gymnastics</osmand:icon>
		 </xsl:when>	 
		
		<!-- hydrant -->
		 <xsl:when test=".='Water Hydrant'">
			<osmand:icon>emergency_fire_hydrant</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Hospital'">
			<osmand:icon>amenity_hospital</osmand:icon>
		 </xsl:when>
		 
		 <!-- house yellow flag-->
		 <xsl:when test=".='Civil'">
			<osmand:icon>house</osmand:icon>
		 </xsl:when>
		 
				 
				 
		 <!-- flags -->
				 <xsl:when test=".='Flag'">
					<osmand:icon>special_flag_stroke</osmand:icon>
				 </xsl:when>
				 
				 <xsl:when test="substring-before(.,',')='Flag'">
					<osmand:icon>special_flag_stroke</osmand:icon>
				 </xsl:when>
				 
		 <xsl:when test=".='Gas Station'">
			<osmand:icon>fuel</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Geocache'">
			<osmand:icon>geocache</osmand:icon>
		 </xsl:when>


		 <xsl:when test=".='Golf Course'">
			<osmand:icon>golf_course</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Horn'">
			<osmand:icon>seamark_notice_regulation_soundhorn</osmand:icon>
		 </xsl:when>		 

			 <xsl:when test=".='Information'">
			<osmand:icon>tourism_information</osmand:icon>
		 </xsl:when>
		 		 
		 <xsl:when test=".='Ice Skating'">
			<osmand:icon>ice_skating</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Library'">
			<osmand:icon>amenity_library</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Light'">
			<osmand:icon>lighting_tower</osmand:icon>
		 </xsl:when>
		 		 
		 
		 <xsl:when test=".='Lodging'">
			<osmand:icon>tourism_hotel</osmand:icon>
		 </xsl:when>
		 


		 <!-- argine -->
		 <xsl:when test=".='Levee'">
			<osmand:icon>water_dam</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Lodge'">
			<osmand:icon>topo_shelter</osmand:icon>
		 </xsl:when>
	
		 
		 <xsl:when test=".='Mall'">
			<osmand:icon>Store</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Marina'">
			<osmand:icon>seamark_harbour_marina</osmand:icon>
		 </xsl:when>
		 		 
		 <xsl:when test=".='Mile Marker'">
			<osmand:icon>topo_milestone</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Military'">
			<osmand:icon>military</osmand:icon>
		 </xsl:when>

		 <xsl:when test=".='Mine'">
			<osmand:icon>natural_cave_entrance</osmand:icon>
		 </xsl:when> 	 

		<!-- Theater -->
				 <xsl:when test=".='Movie Theater'">
					<osmand:icon>amenity_theatre</osmand:icon>
				 </xsl:when>
				 
				 <xsl:when test=".='Live Theater'">
					<osmand:icon>amenity_theatre</osmand:icon>
				 </xsl:when> 
				 
				 <xsl:when test=".='Museum'">
					<osmand:icon>museum</osmand:icon>
				 </xsl:when> 
		 
		<!-- point -->
		 <xsl:when test=".='Waypoint'">
			<osmand:icon>waypoint</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Picnic Area'">
			<osmand:icon>tourism_picnic_site</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test="substring-before(.,',')='Pin'">
			<osmand:icon>special_flag_stroke</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Police Station'">
				<osmand:icon>amenity_police</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Post Office'">
				<osmand:icon>post_office</osmand:icon>
		 </xsl:when>	
		 
		 <xsl:when test=".='Puzzle Cache'">
				<osmand:icon>special_flag_stroke</osmand:icon>
		 </xsl:when>		 


		 
		 <!-- Parking -->
				 <xsl:when test=".='Parking, Euro'">
					<osmand:icon>parking</osmand:icon>
				 </xsl:when>
						 
				 <xsl:when test=".='Parking, Pay'">
					<osmand:icon>parking</osmand:icon>
				 </xsl:when>
		 <xsl:when test=".='Restaurant'">
			<osmand:icon>restaurants</osmand:icon>
		 </xsl:when>
		 <xsl:when test=".='Railway'">
			<osmand:icon>railway_station</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Residence'">
			<osmand:icon>house</osmand:icon>
		 </xsl:when>		 
		 
		 <xsl:when test=".='Restaurant'">
			<osmand:icon>restaurant</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Restroom'">
			<osmand:icon>amenity_toilets</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='RV Park'">
			<osmand:icon>tourism_caravan_site</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Shipwreck'">
			<osmand:icon>historic_ship</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Shopping Center'">
			<osmand:icon>shop</osmand:icon>
		 </xsl:when>		 

		 <!-- Store -->
		 <xsl:when test=".='Store'">
			<osmand:icon>shop</osmand:icon>
		 </xsl:when>	
		 <xsl:when test=".='Department Store'">
			<osmand:icon>shopping_department_store</osmand:icon>
		 </xsl:when>

		 <xsl:when test=".='Stump'">
			<osmand:icon>seamark_obstruction_stump</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Summit'">
			<osmand:icon>natural_peak</osmand:icon>
		 </xsl:when>

		<!-- Tower -->
				 <xsl:when test=".='Tower'">
					<osmand:icon>man_made_mast</osmand:icon>
				 </xsl:when>
				 <xsl:when test=".='Tall Tower'">
					<osmand:icon>man_made_mast</osmand:icon>
				 </xsl:when>
				 
		 <!-- tree icon -->
				 <xsl:when test=".='Park'">
					<osmand:icon>tree</osmand:icon>
				 </xsl:when>		
				 <xsl:when test=".='Forest'">
					<osmand:icon>tree</osmand:icon>
				 </xsl:when>
		  
		 <xsl:when test=".='Toll Booth'">
			<osmand:icon>toll_booth</osmand:icon>
		 </xsl:when>
		  
		 <xsl:when test=".='Tunnel'">
			<osmand:icon>tunnel</osmand:icon>
		 </xsl:when>		 		 
		  
		 <xsl:when test=".='Scenic Area'">
			<osmand:icon>viewpoint</osmand:icon>
		 </xsl:when>		  
		 <xsl:when test=".='School'">
			<osmand:icon>amenity_school</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Skull and Crossbones'">
			<osmand:icon>cross</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Ski Resort'">
			<osmand:icon>ski_resort</osmand:icon>
		 </xsl:when>
		 
		 
		 <xsl:when test=".='Skiing Area'">
			<osmand:icon>ski_resort</osmand:icon>
		 </xsl:when>
		 
		 <xsl:when test=".='Short Tower'">
			<osmand:icon>tower</osmand:icon>
		 </xsl:when>			 
		 
		 <xsl:when test=".='Stadium'">
			<osmand:icon>sport_stadium</osmand:icon>
		 </xsl:when>	
		 
		 <xsl:when test=".='Swimming Area'">
			<osmand:icon>sport_swimming</osmand:icon>
		 </xsl:when>

		 
		 <xsl:when test=".='Telephone'">
			<osmand:icon>amenity_telephone</osmand:icon>
		 </xsl:when>


		 <xsl:when test=".='Drinking Water'">
			<osmand:icon>water_tap</osmand:icon>
		 </xsl:when>			 
		 <xsl:when test=".='Water Source'">
			<osmand:icon>water_tap</osmand:icon>
		 </xsl:when>			
		
		 <xsl:when test=".='Waypoint'">
			<osmand:icon>osmand_waypoint</osmand:icon> <!-- special_information -->
		 </xsl:when>
					 
		<!-- Shapes .................................................................................-->
		<!-- Buoy --> 
				 <xsl:when test="substring-before(.,',')='Buoy'">
					<osmand:icon>seamark_buoy_conical</osmand:icon>
				 </xsl:when>
				 
		<!-- Circle, Colored -->
				 <xsl:when test="substring-before(.,',')='Navaid'">
					<osmand:icon>circle</osmand:icon>
				 </xsl:when>

				 <xsl:when test="substring-before(.,',')='Circle'">
					<osmand:icon>circle</osmand:icon>
				 </xsl:when>	

		 
		 <!-- cube, color --> 
				 <xsl:when test="substring-before(.,',')='Block'">
					<osmand:icon>barrier_block</osmand:icon>
				 </xsl:when>		 
		 
		 <!-- triangle, colored -->
				 <xsl:when test=".='Blue Triangle'">
					<osmand:icon>osmc_blue_triangle</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Black Triangle'">
					<osmand:icon>osmc_black_triangle </osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Green Triangle'">
					<osmand:icon>osmc_green_triangle</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Orange Triangle'">
					<osmand:icon>osmc_orange_triangle</osmand:icon>
				 </xsl:when>
				 <xsl:when test=".='Red Triangle'">
					<osmand:icon>osmc_red_triangle</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='White Triangle'">
					<osmand:icon>osmc_white_triangle</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Yellow Triangle'">
					<osmand:icon>osmc_yellow_triangle</osmand:icon>
				 </xsl:when>

		 <!-- rectangle, colored -->
				 <xsl:when test=".='Blue Rectangle'">
					<osmand:icon>osmc_blue_rectangle</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Black Rectangle'">
					<osmand:icon>osmc_black_rectangle </osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Green Rectangle'">
					<osmand:icon>osmc_green_rectangle</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Orange Rectangle'">
					<osmand:icon>osmc_orange_rectangle</osmand:icon>
				 </xsl:when>
				 <xsl:when test=".='Red Rectangle'">
					<osmand:icon>osmc_red_rectangle</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='White Rectangle'">
					<osmand:icon>osmc_white_rectangle</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Yellow Rectangle'">
					<osmand:icon>osmc_yellow_rectangle</osmand:icon>
				 </xsl:when>
		 
		 <!-- diamond, colored -->
				 <xsl:when test=".='Blue Diamond'">
					<osmand:icon>osmc_blue_diamond</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Black Diamond'">
					<osmand:icon>osmc_black_diamond </osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Green Diamond'">
					<osmand:icon>osmc_green_diamond</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Orange Diamond'">
					<osmand:icon>osmc_orange_diamond</osmand:icon>
				 </xsl:when>
				 <xsl:when test=".='Red Diamond'">
					<osmand:icon>osmc_red_diamond</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='White Diamond'">
					<osmand:icon>osmc_white_diamond</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Yellow Diamond'">
					<osmand:icon>osmc_yellow_diamond</osmand:icon>
				 </xsl:when>

				 <xsl:when test=".='Black-Red Diamond'">
					<osmand:icon>osmc_black_red_diamond</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Purple Diamond'">
					<osmand:icon>osmc_purple_diamond</osmand:icon>
				 </xsl:when>		 
				 <xsl:when test=".='Red-Blue Diamond'">
					<osmand:icon>osmc_red_blue_diamond</osmand:icon>
				 </xsl:when>			 
				 <xsl:when test=".='Red-Green-Grape Diamond'">
					<osmand:icon>osmc_red_diamond_green_grape</osmand:icon>
				 </xsl:when>				
				 <xsl:when test=".='Red-Diamond, Yellow grape'">
					<osmand:icon>osmc_red_diamond_yellow_grape</osmand:icon>
				 </xsl:when>				
				 <xsl:when test=".='White-Black Diamond'">
					<osmand:icon>osmc_white_black_diamond</osmand:icon>
				 </xsl:when>	
				 <xsl:when test=".='White-Red Diamond'">
					<osmand:icon>osmc_white_red_diamond</osmand:icon>
				 </xsl:when>
		
		 <!-- to verify --> 
				 <xsl:when test="substring-before(.,',')='Square'">
					<osmand:icon>square</osmand:icon>
				 </xsl:when> 
							 
				 <xsl:when test=".='TracBack Point'">
					<osmand:icon>point</osmand:icon>
				 </xsl:when> 				 
					 
		 <!-- letters and numbers, colored ...........................................................-->
		 <xsl:when  test="substring-before(.,',')='Number 0'">
			<osmand:icon>special_number_0</osmand:icon>
			<osmand:background>circle</osmand:background>
		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Number 1'">
			<osmand:icon>special_number_1</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Number 2'">
			<osmand:icon>special_number_2</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>		 		 
		 <xsl:when  test="substring-before(.,',')='Number 3'">
			<osmand:icon>special_number_3</osmand:icon>
		 	<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Number 4'">
			<osmand:icon>special_number_4</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Number 5'">
			<osmand:icon>special_number_5</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Number 6'">
			<osmand:icon>special_number_6</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Number 7'">
			<osmand:icon>special_number_7</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Number 8'">
			<osmand:icon>special_number_8</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>		 
		 <xsl:when  test="substring-before(.,',')='Number 9'">
			<osmand:icon>special_number_9</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter A'">
			<osmand:icon>special_letter_a</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter B'">
			<osmand:icon>special_letter_b</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		
		 <xsl:when  test="substring-before(.,',')='Letter C'">
			<osmand:icon>special_letter_c</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		
		 <xsl:when  test="substring-before(.,',')='Letter D'">
			<osmand:icon>special_letter_d</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter E'">
			<osmand:icon>special_letter_e</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter F'">
			<osmand:icon>special_letter_f</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter G'">
			<osmand:icon>special_letter_g</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter H'">
			<osmand:icon>special_letter_h</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter I'">
			<osmand:icon>special_letter_i</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter J'">
			<osmand:icon>special_letter_j</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter K'">
			<osmand:icon>special_letter_k</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter L'">
			<osmand:icon>special_letter_l</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter M'">
			<osmand:icon>special_letter_m</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter N'">
			<osmand:icon>special_letter_n</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter O'">
			<osmand:icon>special_letter_o</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter P'">
			<osmand:icon>special_letter_p</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter Q'">
			<osmand:icon>special_letter_q</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter R'">
			<osmand:icon>special_letter_r</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter S'">
			<osmand:icon>special_letter_s</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter T'">
			<osmand:icon>special_letter_t</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter U'">
			<osmand:icon>special_letter_u</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter X'">
			<osmand:icon>special_letter_x</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter Y'">
			<osmand:icon>special_letter_y</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter W'">
			<osmand:icon>special_letter_w</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>
		 <xsl:when  test="substring-before(.,',')='Letter Z'">
			<osmand:icon>special_letter_z</osmand:icon>
			<osmand:background>circle</osmand:background>
   		 </xsl:when>


		<!-- 
		 <xsl:otherwise>
		   ... some output ....
		 </xsl:otherwise>-->		
		</xsl:choose>



		
		<!-- colorize icons ..................................................................... -->
		<xsl:choose>
		 <xsl:when test="substring-after(.,' ')='Amber' or substring-after(.,', ')='Amber'">
			<osmand:color>amber</osmand:color>
		 </xsl:when>
		 
		 <xsl:when test="substring-after(.,' ')='Blue' or substring-after(.,', ')='Blue'">
			<osmand:color>blue</osmand:color>
		 </xsl:when>	
		 
		 <xsl:when test="substring-after(.,' ')='Green' or substring-after(.,', ')='Green'">
			<osmand:color>#00842b</osmand:color>
		 </xsl:when>
		 		 
		 <xsl:when test="substring-after(.,' ')='Red' or substring-after(.,', ')='Red'">
			<osmand:color>#2196F3</osmand:color>
		 </xsl:when>
		</xsl:choose>

		<!-- adding this to all icons -->
		<osmand:displaymode>SymbolAndName</osmand:displaymode>
	</extensions>
  </xsl:template>
  

	
 </xsl:stylesheet>
 
