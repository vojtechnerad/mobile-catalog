<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xpath-default-namespace="http://example.com/nerv01/mobilni-katalog" exclude-result-prefixes="xs"
    version="2.0">

    <xsl:output method="xml" encoding="utf-8"/>

    <xsl:template match="/">
        <fo:root language="cs">
            <fo:layout-master-set>
                <fo:simple-page-master margin-bottom="2cm" margin-left="2cm" margin-right="2cm"
                    margin-top="2cm" master-name="title-page" page-height="29.7cm" page-width="21cm"
                    margin="1cm">
                    <fo:region-body margin="1cm"/>
                    <fo:region-before extent="0.4cm"/>
                    <fo:region-after extent="0.4cm"/>
                </fo:simple-page-master>

                <fo:simple-page-master margin-bottom="1cm" margin-left="2cm" margin-right="2cm"
                    margin-top="2cm" master-name="main" page-height="29.7cm" page-width="21cm"
                    margin="1cm">
                    <fo:region-body margin="1cm"/>
                    <fo:region-before extent="0.4cm"/>
                    <fo:region-after extent="0.4cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="title-page">
                <fo:flow flow-name="xsl-region-body" font-family="Arial">
                    <fo:block font-size="30px" space-before="5cm" font-weight="bold"
                        text-align="center"> Semestrální práce z předmětu 4IZ238 </fo:block>

                    <fo:block font-size="30px" font-weight="bold" space-before="1cm"
                        text-align="center"> Mobilní katalog </fo:block>

                    <fo:block font-size="30px" font-weight="bold" space-before="1cm"
                        text-align="center"> Vojtěch Nerad </fo:block>
                </fo:flow>
            </fo:page-sequence>

            <fo:page-sequence master-reference="main" font-family="Arial">
                <fo:static-content flow-name="xsl-region-before" font-family="Arial">
                    <fo:block text-align="right">Mobilní katalog [nerv01]</fo:block>
                </fo:static-content>

                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="center">
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>

                <fo:flow flow-name="xsl-region-body">
                    <fo:block-container width="15cm">
                        <fo:block font-weight="bold">Obsah</fo:block>

                        <fo:block>
                            <xsl:for-each select="devices/device">
                                <fo:block text-align-last="justify">
                                    <fo:basic-link internal-destination="{generate-id(.)}">
                                        <xsl:value-of select="brand"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="model/name"/>
                                        <fo:leader leader-pattern="dots"/>

                                        <fo:page-number-citation ref-id="{generate-id(.)}"/>
                                    </fo:basic-link>

                                </fo:block>
                            </xsl:for-each>
                        </fo:block>
                    </fo:block-container>
                    <fo:block-container>
                        <xsl:apply-templates select="devices/device"/>
                    </fo:block-container>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="device">
        <fo:block id="{generate-id(.)}" break-before="page" font-weight="bold" font-size="200%">
            <xsl:value-of select="brand"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="model/name"/>
        </fo:block>

        <fo:block>
            <fo:float float="right">
                <fo:block>
                    <fo:external-graphic src="url('{image/@src}')" content-height="5cm"/>
                </fo:block>
            </fo:float>
        </fo:block>
        <xsl:apply-templates/>

    </xsl:template>

    <xsl:template match="brand"/>
    <xsl:template match="model/name"/>

    <xsl:template match="model/code">
        <fo:block font-style="italic">
            <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>

    <xsl:template match="releasedate">
        <fo:block>
            <xsl:value-of select="format-date(., '[D]. [M]. [Y]')"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="color">
        <fo:block>
            <xsl:value-of select="."/>
        </fo:block>
    </xsl:template>

    <xsl:template match="price">
        <fo:block>
            <xsl:value-of select="."/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="./@currency"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="display">
        <fo:block font-weight="bold" font-size="120%" margin-top="5px"> Display </fo:block>
        <fo:block>
            <xsl:value-of select="type"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="size"/>
            <xsl:text>", </xsl:text>
            <xsl:value-of select="resolution/width"/>
            <xsl:text> &#215; </xsl:text>
            <xsl:value-of select="resolution/height"/>
            <xsl:text> px (</xsl:text>
            <xsl:value-of select="resolution/aspect_ratio"/>
            <xsl:text>)</xsl:text>
        </fo:block>
    </xsl:template>

    <xsl:template match="image"/>

    <xsl:template match="chipset">
        <fo:block font-weight="bold" font-size="120%" margin-top="5px"> Chipset </fo:block>
        <fo:block>
            <xsl:value-of select="brand"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="model"/>
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="cores/core"/>
            <xsl:value-of select="gpu"/>
        </fo:block>
    </xsl:template>

    <xsl:template match="chipset/cores/core">
        <xsl:value-of select="quantity"/>
        <xsl:text> &#215; </xsl:text>
        <xsl:value-of select="name"/>
        <xsl:text> &#64; </xsl:text>
        <xsl:value-of select="frequency"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="frequency/@unit"/>
        <xsl:text>, </xsl:text>
    </xsl:template>

    <xsl:template match="cameras">
        <fo:block font-weight="bold" font-size="120%" margin-top="5px">Kamery</fo:block>
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="cameras/rear">
        <fo:block font-weight="bold"> Zadní </fo:block>
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="cameras/front">
        <fo:block font-weight="bold"> Přední </fo:block>
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="camera">
        <fo:block>
            <xsl:value-of select="resolution"/>
            <xsl:text> Mpx</xsl:text>
            <xsl:if test="focallength">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="focallength"/>
                <xsl:text> mm</xsl:text>
            </xsl:if>

            <xsl:if test="aperture">
                <xsl:text>, f/</xsl:text>
                <xsl:value-of select="aperture"/>
            </xsl:if>

            <xsl:if test="category">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="category"/>
            </xsl:if>
        </fo:block>
    </xsl:template>

    <xsl:template match="memory">
        <fo:block font-weight="bold" font-size="120%" margin-top="5px">Paměti</fo:block>
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="memory/ram">
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./@unit"/>
        <xsl:text> RAM, </xsl:text>
    </xsl:template>

    <xsl:template match="memory/internal">
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./@unit"/>
        <xsl:text> interní</xsl:text>
    </xsl:template>

    <xsl:template match="memory/expansionslot">
        <xsl:text>+ </xsl:text>
        <xsl:value-of select="."/>
    </xsl:template>

    <xsl:template match="system">
        <fo:block font-weight="bold" font-size="120%" margin-top="5px">Systém</fo:block>
        <fo:block>
            <xsl:value-of select="name"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="version"/>
            <xsl:if test="overlay">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="overlay"/>
            </xsl:if>
        </fo:block>
    </xsl:template>

    <xsl:template match="battery">
        <fo:block font-weight="bold" font-size="120%" margin-top="5px">Baterie</fo:block>
        <fo:block>
            <xsl:value-of select="size"/>
            <xsl:text> mAh, </xsl:text>
            <xsl:text>drátové nabíjení </xsl:text>
            <xsl:value-of select="charging/wired"/>
            <xsl:text> W</xsl:text>
            <xsl:if test="charging/wireless">
                <xsl:text>, bezdrátové nabíjení </xsl:text>
                <xsl:value-of select="charging/wireless"/>
                <xsl:text> W</xsl:text>
            </xsl:if>
        </fo:block>
    </xsl:template>

    <xsl:template match="connectors">
        <fo:block font-weight="bold" font-size="120%" margin-top="5px">Konektory</fo:block>
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="connector">
        <xsl:value-of select="."/>
        <xsl:if test="following-sibling::connector">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="comms">
        <fo:block font-weight="bold" font-size="120%" margin-top="5px">Komunikační
            technologie</fo:block>
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="comm">
        <xsl:value-of select="."/>
        <xsl:if test="following-sibling::comm">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="features">
        <fo:block font-weight="bold" font-size="120%" margin-top="5px">Funkce</fo:block>
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="feature">
        <xsl:value-of select="."/>
        <xsl:if test="following-sibling::feature">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="body">
        <fo:block font-weight="bold" font-size="120%" margin-top="5px">Konstrukce</fo:block>
        <fo:block>
            <xsl:value-of select="dimensions/height"/>
            <xsl:text> mm &#215; </xsl:text>
            <xsl:value-of select="dimensions/width"/>
            <xsl:text> mm &#215; </xsl:text>
            <xsl:value-of select="dimensions/depth"/>
            <xsl:text> mm, </xsl:text>
            <xsl:value-of select="weight"/>
            <xsl:text> g</xsl:text>
        </fo:block>
    </xsl:template>

    <xsl:template match="categories">
        <fo:block font-weight="bold" font-size="120%" margin-top="5px">Kategorie</fo:block>
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="category">
        <xsl:value-of select="."/>
        <xsl:if test="following-sibling::category">
            <xsl:text>, </xsl:text>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
