<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>
	
	<xsl:template match="/bottle-shop">
		<html>
		<head>
			<title>My Bottle Shop</title>
			<!-- Kosmetik. Kümmern Sie sich nicht um die styles! -->
			<style>
				img {
					height: 256;
				}
				div.toc {
					border: 1px solid grey;
					float: left;
					width: 128px;
					height: 194px;
					margin: 4px;
					padding: 2px;
					font-family: sans-serif;
					text-align: center;
					background-color: beige;
				}
				div.toc img {
					height: 64px;
				}
				div.toc h2 {
					font-size: 100%;
				}
				div.toc p {
					font-size: 75%;
 					margin: 0;
  					padding: 0;
				}
			</style>
		</head>
		<body>
			<h1>My Bottle Shop</h1>
			
			<!-- Inhaltsübersicht -->
			<xsl:for-each select="beverage">
				<div class="toc">
					<h2><a href="#{generate-id()}"><xsl:value-of select="@name"/></a></h2>
					<xsl:if test="image">
						<img src="{image}"></img>
					</xsl:if>
					<xsl:for-each select="package">
						<p>
							<xsl:value-of select="@volume"/>L,
							€ <xsl:value-of select="@price"></xsl:value-of>
						</p>
					</xsl:for-each>
				</div>
			</xsl:for-each>
			<div style="clear: left"></div>
			
			<xsl:apply-templates select="beverage"/>
			
		</body>
		</html>
	</xsl:template>
	
	<!-- Ergänzen Sie das stylesheet hier.
	
	Beachten Sie:
	* Für jedes Bier gibt es eine Detaildarstellung mit Überschrift, Bild und Text.
	* Der h2-Titel in der Inhaltsübersicht soll auf die Überschrift der Detaildarstellung
	  eines Bieres verlinken.
	* Nicht jedes Bier hat ein Bild. Das Bild soll nur dann erscheinen,
	  wenn ein entsprechendes Element existiert.
	* Die Beschreibung eines Bieres besteht aus mehreren Absätzen,
	  die manchmal eine Überschrift haben, zB beim Champagner-Bier. 
	* Bei der empfohlenen Trinktemperatur wird nur der Celsius Bereich dargestellt.
	* Produzieren Sie simple HTML-Elemente und kümmern Sie sich nicht um das Styling.
	-->

	<xsl:template match="beverage">
		<hr/>
		<h2 id="{generate-id()}"><xsl:value-of select="@name"/></h2>
		<xsl:if test="image">
			<img src="{image}"/>
			<br/>
			<br/>
		</xsl:if>
		<xsl:for-each select="description">
			<xsl:choose>
				<xsl:when test="@headline">
					<h3><xsl:value-of select="@headline"/></h3>
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<br/>
		<br/>
		<xsl:value-of select="concat('Alk: ', @alc-by-vol, '% Vol.')"/>
		<br/>
		<br/>
		<xsl:value-of select="concat('Empfohlene Trinktemperatur: ', drink-at[@unit='C']/@min-temp, ' - ', drink-at[@unit='C']/@max-temp, ' °C')"></xsl:value-of>
	</xsl:template>
</xsl:stylesheet>
