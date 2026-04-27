<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes"/>

    <!-- ============================================================ -->
    <!--  PLANTILLA RAÍZ — Genera el esqueleto HTML completo          -->
    <!-- ============================================================ -->
    <xsl:template match="/">
        <html lang="es">
        <head>
            <meta charset="UTF-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
            <title><xsl:value-of select="catalogo/@nombre"/></title>
            <style>
                /* === RESET Y FUENTES === */
                * { margin: 0; padding: 0; box-sizing: border-box; }
                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background-color: #0d0d1a;
                    color: #e0e0e0;
                    padding: 40px 20px;
                }

                /* === CABECERA === */
                header {
                    text-align: center;
                    margin-bottom: 50px;
                }
                header h1 {
                    font-size: 2.8rem;
                    color: #a78bfa;
                    letter-spacing: 2px;
                    text-transform: uppercase;
                }
                header p {
                    color: #888;
                    margin-top: 8px;
                    font-size: 0.95rem;
                }

                /* === GRID DE TARJETAS === */
                .catalogo {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
                    gap: 30px;
                    max-width: 1200px;
                    margin: 0 auto;
                }

                /* === TARJETA === */
                .tarjeta {
                    background-color: #1a1a2e;
                    border-radius: 16px;
                    padding: 28px;
                    border: 1px solid #2a2a4a;
                    transition: transform 0.2s, box-shadow 0.2s;
                }
                .tarjeta:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 10px 30px rgba(167, 139, 250, 0.15);
                }

                /* === ENCABEZADO DE TARJETA === */
                .tarjeta-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: flex-start;
                    margin-bottom: 14px;
                    gap: 10px;
                }
                .tarjeta h2 {
                    font-size: 1.25rem;
                    color: #ffffff;
                    line-height: 1.3;
                }

                /* === BADGE DE GÉNERO === */
                .badge-genero {
                    font-size: 0.7rem;
                    font-weight: bold;
                    text-transform: uppercase;
                    padding: 4px 10px;
                    border-radius: 20px;
                    white-space: nowrap;
                    background-color: #a78bfa22;
                    color: #a78bfa;
                    border: 1px solid #a78bfa55;
                }

                /* === BADGE NUEVO (juego del año actual o reciente) === */
                .badge-nuevo {
                    font-size: 0.7rem;
                    font-weight: bold;
                    text-transform: uppercase;
                    padding: 4px 10px;
                    border-radius: 20px;
                    background-color: #22c55e22;
                    color: #22c55e;
                    border: 1px solid #22c55e55;
                    margin-left: 6px;
                }

                /* === DESCRIPCIÓN === */
                .descripcion {
                    font-size: 0.88rem;
                    color: #aaa;
                    line-height: 1.6;
                    margin-bottom: 18px;
                }

                /* === SECCIONES INTERNAS === */
                .seccion {
                    margin-bottom: 16px;
                }
                .seccion-titulo {
                    font-size: 0.75rem;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    color: #a78bfa;
                    margin-bottom: 8px;
                    font-weight: bold;
                }

                /* === DESARROLLADORA === */
                .dev-info {
                    font-size: 0.88rem;
                    color: #ccc;
                }
                .dev-info span {
                    color: #888;
                }

                /* === PLATAFORMAS === */
                .plataformas {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 6px;
                }
                .plataforma-tag {
                    font-size: 0.75rem;
                    padding: 3px 10px;
                    border-radius: 12px;
                    background-color: #2a2a4a;
                    color: #ccc;
                    border: 1px solid #3a3a6a;
                }
                /* Color por tipo de plataforma */
                .tipo-consola  { border-color: #60a5fa55; color: #60a5fa; background-color: #60a5fa11; }
                .tipo-pc       { border-color: #f59e0b55; color: #f59e0b; background-color: #f59e0b11; }
                .tipo-portatil { border-color: #34d39955; color: #34d399; background-color: #34d39911; }
                .tipo-movil    { border-color: #f472b655; color: #f472b6; background-color: #f472b611; }

                /* === MODOS DE JUEGO === */
                .modo {
                    background-color: #12122a;
                    border-radius: 8px;
                    padding: 10px 14px;
                    margin-bottom: 8px;
                    font-size: 0.85rem;
                }
                .modo-nombre {
                    font-weight: bold;
                    color: #fff;
                    margin-bottom: 4px;
                }
                .modo-jugadores {
                    font-size: 0.75rem;
                    color: #a78bfa;
                    margin-bottom: 4px;
                }
                .modo-desc {
                    color: #999;
                    line-height: 1.5;
                }

                /* === SINGLEPLAYER / MULTIJUGADOR === */
                .tag-single { color: #fbbf24; }
                .tag-multi  { color: #34d399; }

                /* === PIE DE PÁGINA === */
                footer {
                    text-align: center;
                    margin-top: 60px;
                    color: #444;
                    font-size: 0.8rem;
                }
            </style>
        </head>
        <body>

            <header>
                <h1><xsl:value-of select="catalogo/@nombre"/></h1>
                <p>Versión <xsl:value-of select="catalogo/@version"/> ·
                   <xsl:value-of select="count(catalogo/juego)"/> juegos en el catálogo
                </p>
            </header>

            <!-- ================================================== -->
            <!--  BUCLE principal: recorre todos los juegos          -->
            <!--  ORDENACIÓN: alfabética por título                  -->
            <!-- ================================================== -->
            <div class="catalogo">
                <xsl:for-each select="catalogo/juego">
                    <xsl:sort select="titulo" order="ascending"/>

                    <div class="tarjeta">

                        <!-- Cabecera: título + badge género -->
                        <div class="tarjeta-header">
                            <h2><xsl:value-of select="titulo"/></h2>
                            <span class="badge-genero">
                                <xsl:value-of select="@genero"/>
                            </span>
                        </div>

                        <!-- ======================================== -->
                        <!--  CONDICIONAL 1:                          -->
                        <!--  Si el juego es de 2024 en adelante,    -->
                        <!--  muestra un badge "Nuevo"               -->
                        <!-- ======================================== -->
                        <xsl:if test="requisitos_tecnicos/anio_lanzamiento &gt;= 2024">
                            <span class="badge-nuevo">⭐ Nuevo</span>
                        </xsl:if>

                        <!-- Descripción -->
                        <p class="descripcion">
                            <xsl:value-of select="descripcion"/>
                        </p>

                        <!-- Desarrolladora -->
                        <div class="seccion">
                            <div class="seccion-titulo">Desarrolladora</div>
                            <div class="dev-info">
                                <xsl:value-of select="desarrolladora/nombre"/>
                                <span> · <xsl:value-of select="desarrolladora/pais"/></span>

                                <!-- ================================ -->
                                <!--  CONDICIONAL 2:                  -->
                                <!--  Muestra el publisher solo       -->
                                <!--  si existe en el XML            -->
                                <!-- ================================ -->
                                <xsl:if test="desarrolladora/publisher">
                                    <span> · Pub: <xsl:value-of select="desarrolladora/publisher"/></span>
                                </xsl:if>
                            </div>
                        </div>

                        <!-- Año de lanzamiento -->
                        <div class="seccion">
                            <div class="seccion-titulo">Lanzamiento</div>
                            <div class="dev-info">
                                <xsl:value-of select="requisitos_tecnicos/anio_lanzamiento"/>
                            </div>
                        </div>

                        <!-- Plataformas -->
                        <div class="seccion">
                            <div class="seccion-titulo">Plataformas</div>
                            <div class="plataformas">
                                <!-- BUCLE: recorre cada plataforma del juego -->
                                <xsl:for-each select="requisitos_tecnicos/plataforma">

                                    <!-- ============================== -->
                                    <!--  CONDICIONAL 3:               -->
                                    <!--  Aplica clase CSS según tipo  -->
                                    <!-- ============================== -->
                                    <xsl:choose>
                                        <xsl:when test="@tipo='consola'">
                                            <span class="plataforma-tag tipo-consola">
                                                <xsl:value-of select="."/>
                                            </span>
                                        </xsl:when>
                                        <xsl:when test="@tipo='PC'">
                                            <span class="plataforma-tag tipo-pc">
                                                <xsl:value-of select="."/>
                                            </span>
                                        </xsl:when>
                                        <xsl:when test="@tipo='portátil'">
                                            <span class="plataforma-tag tipo-portatil">
                                                <xsl:value-of select="."/>
                                            </span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <span class="plataforma-tag tipo-movil">
                                                <xsl:value-of select="."/>
                                            </span>
                                        </xsl:otherwise>
                                    </xsl:choose>

                                </xsl:for-each>
                            </div>
                        </div>

                        <!-- Modos de juego -->
                        <div class="seccion">
                            <div class="seccion-titulo">Modos de juego</div>

                            <!-- BUCLE: recorre cada modo del juego -->
                            <xsl:for-each select="modos_de_juego/modo">
                                <div class="modo">
                                    <div class="modo-nombre">
                                        <xsl:value-of select="nombre_modo"/>
                                    </div>

                                    <!-- ============================== -->
                                    <!--  CONDICIONAL 4:               -->
                                    <!--  Distingue si es single o     -->
                                    <!--  multijugador por jugadores   -->
                                    <!-- ============================== -->
                                    <div class="modo-jugadores">
                                        <xsl:choose>
                                            <xsl:when test="@jugadores = '1'">
                                                <span class="tag-single">👤 Un jugador</span>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <span class="tag-multi">👥 <xsl:value-of select="@jugadores"/> jugadores</span>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </div>

                                    <div class="modo-desc">
                                        <xsl:value-of select="descripcion_modo"/>
                                    </div>
                                </div>
                            </xsl:for-each>

                        </div>
                    </div>

                </xsl:for-each>
            </div>

            <footer>
                <p>Catálogo generado mediante transformación XSLT · Fase 2</p>
            </footer>

        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>