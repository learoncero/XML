<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template match="/brew-recipes">
		<html>
			<head>
				<title>Some Recipes from "Brew Your Own" Magazine</title>
			</head>
			<body>
				<h1>Some Recipes from "Brew Your Own" Magazine</h1>
				
				<xsl:apply-templates select="recipe"/>
				
				<h2>Index of Grains</h2>
				<ul>
					<xsl:apply-templates select="recipe/ingredients/grain"/>
				</ul>
			</body>
		</html>
	</xsl:template>
	
	<!-- Hier wird Ihr Lösungscode eingesetzt. -->
	
	<xsl:template match="recipe">
		<h2 id="{generate-id()}"><xsl:value-of select="@name"/></h2>
		<h3>Ingredients</h3>
		<ul>
			<xsl:for-each select="ingredients/grain">
				<xsl:choose>
					<xsl:when test="@color">
						<li>
							<xsl:value-of select="concat(@type, ' (', @color, ')', ' (', @amount, ')')"/>
						</li>
					</xsl:when>
					<xsl:otherwise>
						<li>
							<xsl:value-of select="concat(@type, ' (', @amount, ')')"/>
						</li>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:for-each select="ingredients/hops">
				<li>
					<xsl:value-of select="."/>
					<xsl:value-of select="concat(' (', @amount, ' at ', @alpha, ' alpha acids, ', @minutes-before-boil-end, ' min.)')"/>
				</li>
			</xsl:for-each>
			<xsl:for-each select="ingredients/yeast">
				<li>
					<xsl:value-of select="."/>
				</li>
			</xsl:for-each>
		</ul>
			
		<h3>Steps</h3>
		<xsl:for-each select="step">
			<xsl:value-of select="."/>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="recipe/ingredients/grain">
			<li>
				<xsl:value-of select="@type"/>
					<i> 
					<xsl:text>
						used in: 
					</xsl:text>
					<a href="#{generate-id(ancestor::recipe)}">
						<xsl:value-of select="ancestor::recipe/@name"/>
					</a>
				</i>
			</li>
	</xsl:template>

</xsl:stylesheet>
