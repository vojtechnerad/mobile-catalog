<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://example.com/nerv01/mobilni-katalog" exclude-result-prefixes="xs"
    version="2.0">

    <xsl:output method="html" version="5" encoding="UTF-8"/>

    <xsl:template match="/">
        <html lang="cs">
            <head>
                <title>Mobilní katalog</title>
                <link rel="stylesheet" href="css/style.css"/>
            </head>
            <body>
                <header>Katalog mobilních telefonů</header>
                <xsl:for-each-group select="devices/device" group-by="brand">
                    <xsl:sort select="brand"/>                    
                        <h2><xsl:value-of select="current-grouping-key()"/></h2>                       
                    
                    <xsl:for-each select="current-group()">
                        <div class="item">
                            <a href="weby_telefony/{generate-id()}.html">
                                <em>
                                    <xsl:value-of select="brand"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="model/name"/>
                                </em>
                            </a>
                        </div>                        
                    </xsl:for-each>
                    
                </xsl:for-each-group>
                <!-- <xsl:for-each select="devices/device">
                    <xsl:sort select="brand" data-type="text"/>
                    <div class="item">
                        <a href="weby_telefony/{generate-id()}.html">
                            <em>
                                <xsl:value-of select="brand"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="model/name"/>
                            </em>
                        </a>
                    </div>
                </xsl:for-each> -->
                
                <xsl:apply-templates select="devices/device"/>
                <footer> Vojtěch Nerad [nerv01@vse.cz] </footer>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="devices">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="device">
        <xsl:result-document href="weby_telefony/{generate-id()}.html">
            <html lang="cs">
                <head>
                    <title>
                        <xsl:value-of select="brand"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="model/name"/>
                    </title>
                    <link rel="stylesheet" href="../css/style.css"/>
                    <link rel="stylesheet" href="../css/item.css"/>
                </head>
                <body>
                    <header>Katalog mobilních telefonů</header>
                    <a href="../webova_stranka.html"> &#8592; <em>Zpět na katalog</em>
                    </a>
                    <main>
                        <div class="mobileTitle">
                            <h1>
                                <xsl:value-of select="brand"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="model/name"/>
                            </h1>
                            <div class="modelCode">
                                <xsl:text>[</xsl:text>
                                <xsl:value-of select="model/code"/>
                                <xsl:text>]</xsl:text>
                            </div>
                        </div>
                        <div class="additionalInfo"> </div>
                        <xsl:apply-templates/>
                    </main>
                    <footer> Vojtěch Nerad [nerv01@vse.cz] </footer>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="brand"/>
    <xsl:template match="model/name"/>
    <xsl:template match="model/code"/>
    <xsl:template match="releasedate">
        <strong>Datum vydání </strong>
        <xsl:value-of select="format-date(., '[D]. [M]. [Y]')"/>
        <br/>
    </xsl:template>
    
    <xsl:template match="color">
        <strong>Barva </strong>
        <xsl:value-of select="."/>
        <br/>
    </xsl:template>
    
    <xsl:template match="price">
        <strong>Cena </strong>
        <xsl:value-of select="."/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="./@currency"/>
    </xsl:template>
    
    <xsl:template match="image">
        <div class="image">
            <img src="../{@src}" alt="Obrázek telefonu {@src}"></img>
        </div>        
    </xsl:template>

    <xsl:template match="display">
        <article>
            <h2>Display</h2>
            <table>
                <xsl:apply-templates/>
            </table>
        </article>
    </xsl:template>

    <xsl:template match="display/type">
        <tr>
            <td>
                <strong>Typ</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="display/size">
        <tr>
            <td>
                <strong>Úhlopříčka</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
                <xsl:text>"</xsl:text>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="display/resolution">
        <tr>
            <td>
                <strong>Rozlišení</strong>
            </td>
            <td>
                <xsl:value-of select="width/."/>
                <xsl:text> &#215; </xsl:text>
                <xsl:value-of select="height/."/>
            </td>
        </tr>
        <tr>
            <td>
                <strong>Poměr stran</strong>
            </td>
            <td>
                <xsl:value-of select="aspect_ratio/."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="chipset">
        <article>
            <h2>Chipset</h2>
            <table>
                <xsl:apply-templates/>
            </table>
        </article>
    </xsl:template>

    <xsl:template match="chipset/brand">
        <tr>
            <td>
                <strong>Značka</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="chipset/model">
        <tr>
            <td>
                <strong>Model</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="chipset/cores">
        <tr>
            <td>
                <strong>Jádra</strong>
            </td>
            <td>
                <xsl:apply-templates/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="chipset/cores/core">
        <xsl:value-of select="quantity"/>
        <xsl:text> &#215; </xsl:text>
        <xsl:value-of select="name"/>
        <xsl:text>  &#64; </xsl:text>
        <xsl:value-of select="frequency"/>
        <xsl:text>  </xsl:text>
        <xsl:value-of select="frequency/@unit"/>
        <br/>
    </xsl:template>

    <xsl:template match="chipset/gpu">
        <tr>
            <td>
                <strong>Grafický čip</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="cameras">
        <article>
            <h2>Kamery</h2>
            <xsl:apply-templates/>
        </article>
    </xsl:template>

    <xsl:template match="cameras/rear/camera">
        <h3>Zadní kamera</h3>
        <!-- todo kamera číslo -->
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="cameras/front/camera">
        <h3>Přední kamera</h3>
        <!-- todo kamera číslo -->
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="camera/resolution">
        <tr>
            <td>
                <strong>Rozlišení</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
                <xsl:text> Mpx</xsl:text>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="camera/focallength">
        <tr>
            <td>
                <strong>Ohnisková vzdálenost</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
                <xsl:text> mm</xsl:text>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="camera/aperture">
        <tr>
            <td>
                <strong>Clona</strong>
            </td>
            <td>
                <xsl:text>f/</xsl:text>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="camera/category">
        <tr>
            <td>
                <strong>Kategorie</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="memory">
        <h2>Paměti</h2>
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="memory">
        <h2>Paměti</h2>
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="memory/ram">
        <tr>
            <td>
                <strong>Operační paměť</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="./@unit"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="memory/internal">
        <tr>
            <td>
                <strong>Interní paměť</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="./@unit"/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="memory/expansionslot">
        <tr>
            <td>
                <strong>Rozšiřující slot</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="system">
        <h2>Operační systém</h2>
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="system/name">
        <tr>
            <td>
                <strong>Název</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="system/version">
        <tr>
            <td>
                <strong>Verze</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="system/overlay">
        <tr>
            <td>
                <strong>Nadstavba</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="battery">
        <h2>Baterie a nabíjení</h2>
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="battery/size">
        <tr>
            <td>
                <strong>Velikost</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
                <xsl:text> mAh</xsl:text>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="charging/wired">
        <tr>
            <td>
                <strong>Drátové nabíjení</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
                <xsl:text> W</xsl:text>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="charging/wireless">
        <tr>
            <td>
                <strong>Bezdrátové nabíjení</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
                <xsl:text> W</xsl:text>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="connectors">
        <h2>Konektory</h2>
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="connector">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>

    <xsl:template match="comms">
        <h2>Komunikační technologie</h2>
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="comm">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>

    <xsl:template match="features">
        <h2>Funkce</h2>
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="feature">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>

    <xsl:template match="body">
        <h2>Konstrukce</h2>
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <xsl:template match="body/dimensions">
        <tr>
            <td>
                <strong>Rozměry</strong>
            </td>
            <td>
                <xsl:value-of select="./height"/>
                <xsl:text> mm &#215; </xsl:text>
                <xsl:value-of select="./width"/>
                <xsl:text> mm &#215; </xsl:text>
                <xsl:value-of select="./depth"/>
                <xsl:text> mm</xsl:text>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="body/weight">
        <tr>
            <td>
                <strong>Váha</strong>
            </td>
            <td>
                <xsl:value-of select="."/>
                <xsl:text> g</xsl:text>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="categories">
        <h2>Kategorie</h2>
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>

    <xsl:template match="category">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>






</xsl:stylesheet>
